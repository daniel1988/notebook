## Redis提供不同范畴的持久化方案：

    >如果你想，你也可以不用Redis 的持久化。如果你想你的数据只是当server开启时存在的话。
RDB按指定的时间执行对数据集进行实时快照（snapshot) 而实现Redis的持久化。AOF记录Server的每个写操作，当重启server时，会重建原始的数据集。 命令也用Redis协议本身一样被追加到日志记录中。Redis会在后台重写这些日志，当数据变得大了。
同时使用AOF与RDB也是有可能的。当Redis重启时，AOF文件就会用来重建原始数据集保证绝大数据的完整性。最重要的是权衡RDB与AOF的持久性。


## RDB优点

    * RDB是对数据恢复应用得非常好。  一个压缩文件可以转移到数据中心去。或者放到Amazon S3（最好加密下）
    * RDB 是一个压缩的实时再现Redis 数据的单一文件。 RDB文件用于备分是最好的了。有时你可能想把最近24小时内的数据每小时存档起来。 并且放在RDB快照中30天。 这你就得存储不同版本的数据以防灾难。
    * RDB为了 达到Redis性能的最佳，Redis的持久化主要是fork一个子进程来处理。父进程不会处理磁盘IO之类的事

## RDB缺点

    * RDB不太适合如果你想数据最小的数据丢失当Redis停止工作（如：断电）。你可以配制不同的存储节点当RDB用来工作时（如最少是5分钟和100个对数据集的写操作，但可以用不同的save points） 然而你通常创建一个RDBsnapshop 每五分钟或更久。So假如Redis非正常停止运行，你要做好准备丢失那几分钟的数据
    * RDB需要经常fork()  一个子进程来进行持久化操作。  fork()是需要消耗时间如果数据集的数据很大的话。 这样也许会导致Redis 停止存储客户端几毫秒或者一秒，如果数据集非常大、cpu又不是很好时。 AOF也同样要fork() 但是你可以调节多久你想要回写日志 without any trade-off on durability.

## AOF优点

    用AOF更durable，    你可以用不同的 fsync policies： No fsync at all  、   fsync every second、fsync at every query。    默认的策略是fsync every second 写还不错（  fsync is performed using a background thread and the main thread will try hard to perform writes when no fsync is in progress.）但你会丢掉一秒内的worth of writes AOF Log 是一个设置有搜索路径唯一日志，所以没有搜索问题，也不会由于断电而产生数据损坏问题。 即使日志在half-written 命令下停止由于某些原因（磁盘满了或者其它）  Redis-Check-Aof 工具也会很容易地修复。Redis能在后台自动回写Aof 当数据变大的时候。 回写操作绝对安全当Redis连续append到一个老文 件时候。当需要生成一个当前数据集时，则会以最小集合操作生成一个新文件。 一但这第二个文件准备好后，Redis就会切换到追写到这个新文件中。AOF包含了很多一个接一个的操作，以便于理解和解析格式。 你甚至可以导出一个AOF文件。例如即使你flush 所有数据为了一个错误而用FLUSHALL 命令。如果没有修改被执行的日志，在此同时你仍然可以保存您的数据集只是停止服务器， 删除最近的命令，重启Redis。

## AOF缺点

    * AOF文件通常比等量数据集的RDB文件要大
    * AOF要比RDB慢根据fsync策略。  通常“fsync set to every second”的性能还是相当的高的。 如果不用fsync ， 在高负载的情况要比RDB还要快。  当然RDB能提供更多的保证关于最大潜伏期甚至在巨大的写负载上。
    * 过去，我们体验过极其少有的bugs 在特定的命令里面（例如：一个涉及阻塞的命令像 BRPOPPUSH） 导致AOF产生不复制一样的数据集的加载。这个bug极其少见，我们在测试用例随机生成复杂的数据集自动加载，但检查时everything is ok， 但这种bug在RDB中是完全不可能的。为了突出这一点：Redis AOF 递增地更新一个已存在的状态，像Mysql 或者MongoDB做的一样。 然而RDB 快照是从零开始创建一次又一次的。这点上面RDB要更强健一点。 然而1）应该注意到每次AOF回写Redis它是从头重新创建从实际数据中包含的数据集，这使得抵挡bugs比经常追加的AOF文件更强。

    >We never had a single report from users about an AOF corruption that was detected in the real world.

