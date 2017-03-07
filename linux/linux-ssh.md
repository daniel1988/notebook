## SSH原理与运用


### 什么是SSH

    简单说，ssh是一种网络协议，用于计算机之间的加密登录。

    如果一个用户从本地计算机，使用ssh协议登录另一台远程计算机，我们就可以认为，这种登录是安全的即使被中途截获，密码也不会泄露。

### 基本的用法

    ssh主要用于远程登录。假定你要以用户名user，登录远程主机host
```
    $ ssh user@host
```

    如果本地用户名与远程用户名一致，登录时可以省略用户名：` $ ssh host`

    ssh 默认的端口是22　也就是说，你登录请求会送到远程主机的22端口。使用p参数，可以修改这个端口。

```
$ ssh -p 2222 user@host
```

### 中间人攻击

    ssh之所以能够保证安全，原因在于采用了公钥加密。整个流程如下：

    * 远程主机收到用户的登录请求，把自己的公钥发给用户。

    * 用户使用这个公钥，将登录密码加密后，发送回来。

    * 远程主机用自己的私钥，解密登录密码，如果密码正确就同意用户登录。

> 这个过程本身是安全的，但是实施的时候存在一个风险：如果有人截获了登录请求，然后冒充远程主机，将伪造的公钥发给用户　
那么用户就很难辨别真伪。因为不像https协议，ssh协议的公钥是没有证书中心(CA)公证的，也就是说，都是自己签发的。
可以设想，如果攻击者插在用户与远程主机之间（比如公共的wifi区域），用伪造的公钥，获取用户的登录密码再用这个密码登录远程主机
那么ssh的安全机制就荡然无存了。这种风险就是著名的[中间人攻击](https://en.wikipedia.org/wiki/Man-in-the-middle_attack)

### 口令登录

    如果你是第一次登录主机，系统会提示以下:
```
$ ssh user@host
　　The authenticity of host 'host (12.18.429.21)' can't be established.
　　RSA key fingerprint is 98:2e:d7:e0:de:9f:ac:67:28:c2:42:2d:37:16:58:4d.
　　Are you sure you want to continue connecting (yes/no)?
```

> 这段话的意思是，无法确认host主机的真实性，只知道它的公钥指纹，问你还想继续连接吗？
公钥指纹是批公钥长度较长（这里采用RSA算法，长达1024位），很难比对，所以对其进行md5计算，将它变成一个128位的指纹。
假定经过风险衡量以后，用户决定接受这个远程主机的公钥。系统会提示对主机已经得到认可：

```
　Warning: Permanently added 'host,12.18.429.21' (RSA) to the list of known hosts.
```

> 最后输入密码就可以登录了。　当远程主机的公钥接受以后，它会保存在文件$HOME/.ssh/known_hosts之中。下次再次连接这台主机，系统就会
认出它的已经保存在本地了，从而跳过警告。直接提示输入密码。每个ssh用户都有自己的known_hosts文件，此外系统也有一个这样的文件通常是
/etc/ssh/ssh_known_hosts保存一些对所有用户都可以信赖的主机公钥。

### 公钥登录

使用密码登录，每次都必须输入密码，非常麻烦，好在ssh还提供了公钥登录，可以省去输入密码的步骤。

所谓“公钥登录”，原理很简单，就是用户将自已的公钥储存在远程主机上，登录的时候，远程主机会向用户发送一段随机字符串，用户用自己的私钥
加密后，再发回来，远程主机用事先我储存的公钥进行解密，如果成功，就证明用户是可信的，直接色诱登录shell，不再要求密码。

这种方法要求用户必须提供自己的公钥。如果没有现成的，可以直接用ssh-keygen生成一个：
```
$ ssh-keygen
```

运行上面的命令以后，系统会出现一系列的提示，可以一路回车，其中有一个问题是，要不要对私钥设置口令，如果担心私钥的安全可以设置一下。

运行结束以后$HOME/.ssh目录下会有两个id_rsa.pub 和id_rsa前者是公钥，后者是私钥。

这时再输入下面的命令，将公钥传送到远程主机host上面：｀$ ssh-copy-id user@host`　　从此就不需要输入密码了。

如果还不行，打开远程主机/etc/ssh/sshd_config这个文件，检查下面几行前面"#" 注释是否取掉。
```
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
```
然后重启主机ssh服务　｀sudo service ssh restart`

### authorized_keys 文件

远程主机将用户的公钥，保存在登录后的用户主目录$HOME/.ssh/authorized_keys文件中。公钥就是一段字符串，只要把它追加在authorized_keys文件
末尾就行了。

这里不再使用ssh-copy-id命令，改用下面的命令，解释保存过程
```
$ ssh user@host 'mkdir -p .ssh && cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub
```
这条命令由多个语句组成，依次分解开来看：

    （1）"$ ssh user@host"，表示登录远程主机；

    （2）单引号中的mkdir .ssh && cat >> .ssh/authorized_keys，表示登录后在远程shell上执行的命令;

    （3）"$ mkdir -p .ssh"的作用是，如果用户主目录中的.ssh目录不存在，就创建一个；

    （4）'cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub的作用是，将本地的公钥文件~/.ssh/id_rsa.pub，重定向追加到远程文件authorized_keys的末尾



