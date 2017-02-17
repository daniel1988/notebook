##加载JS文件

RequireJS的目标是鼓励代码的模块化，它使用了不同于传统<script>标签的脚本加载步骤。可以用它来加速<br>
优化代码，但其主要目的还是为了代码的模块化。它鼓励在使用脚本时以module ID 代替URL地址。

ReQuireJS以一个相对于baseURL的地址来加载所有的代码。页面顶层<script>标签含有一个特殊的属性data-main<br>
require.js使用它来启动脚本加载，而baseUrl一般设置到与该属性相一致的目录。下列示例中展示了baseUrl的设置：<br>

```
<!--This sets the baseUrl to the "scripts" directory, and
    loads a script that will have a module ID of 'main'-->
<script data-main="scripts/main.js" src="scripts/require.js"></script>
```

baseUrl变可通过RequireJS config 手动设置，如果没有指定config及data-main , 则默认的baseUrl为包含RequireJs的<br>
那个html页面的所属目录。

RequireJs默认假定所有的依赖资源都是js脚本，因此无需在module ID上再加.js 后缀， Requirejs 在进行module ID符合<br>
下述规则之一，其ID解析会避开常 规的"baseUrl + paths" 配制 ，而是直接将其加载为一个相对 于当前HTML文档的脚本：<br>

