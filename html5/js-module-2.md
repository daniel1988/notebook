# WebPack 简介

WebPack是当下最热门的前端资源模块化管理和打包工具。它可以将许多松散的模块按照依赖和规则成符合生产环境<br>
的前端资源。还可以将需加载的模块进行代码分隔，等到实际需要的时候再异步加载。通过loader的转换，任何形式<br>
的资源都可以视作模块，比如CommonJs模块，AMD模块, ES6模块, CSS, 图片, JSON, Coofeescript, LESS等　


# 模块系统的演进

模块系统主要解决模块的定义，依赖和导出。

## <script>标签
```
<script src="module1.js"></script>
<script src="module2.js"></script>
<script src="libraryA.js"></script>
<script src="module3.js"></script>
```
> 这是最原始的js文件加载方式，如果把每个文件看做一个模块，那么他们的接口通常是暴露在全局作用域下，也就是<br>
window对象中，不同模块的接口调用都是一个作用域中，一些复杂的框架，会使用命名空间的概念来组织这些模块的接口<br>
典型的例子如YUI库。

### 缺点

* 全局作用域下容易赞成变量冲突

* 文件只能按照<script>的书写顺序进行加载

* 开发人员必须解决模块和代码库的依赖关系

* 在大型项目中各种资源难以管理，长期积累的问题导致代码库混乱不堪

## CommonJS

服务器端的Node.js遵循[CommonJS规范](http://wiki.commonjs.org/wiki/CommonJS),该规范的核心思想是允许模块通过require方法来同步加载<br>
所有依赖的其他模块，然后通过exports或module.exports来导出需要暴露的接口。

```
require("module");
require("../file.js");
exports.doStuff = function() {};
module.exports = someValue;
```

### 优点：

* 服务器端模块便于重用

* NPM中已经有将近20万个可以使用模块包

* 简单并容易使用

###　缺点：

* 同步的模块加载方式不适合在浏览器环境中，同步意味着阻塞加载，浏览器资源是异步加载的。

* 不能非阻塞的并行加载多个模块

## AMD

[Asynchronous Module Definition](https://github.com/amdjs/amdjs-api)规范其实只有一个主要接口define(id?, dependencies?, factory), <br>
它要在声明模块的时候指定所有的依赖，并且还要当做形参传到factory中，对于依赖的模块提前执行，依赖前置
```
define("module", ["dep1", "dep2"], function(d1, d2) {
  return someExportedValue;
});
require(["module", "../file"], function(module, file) { /* ... */ })
```
###　优点：

* 适合在浏览器环境中异步加载模块

* 可以并行加载多个模块

### 缺点：

* 提高了开发成本，代码的总计和书写比较困难，模块定义方式的语义不顺畅

* 不符合通用的模块化思维方式

### 实现：

* [Require JS](http://requirejs.org/)

* [curl](https://github.com/cujojs/curl)

## CMD

[Common Module Definition](https://github.com/cmdjs/specification/blob/master/draft/module.md)规范和AMD很相似，尽量保持简单，<br>
并与CommonJS和Node.js的Modules 规范保持了很大的兼容性

```
define(function(require, exports, module) {
  var $ = require('jquery');
  var Spinning = require('./spinning');
  exports.doSomething = ...
  module.exports = ...
})
```

### 优点：

* 依赖就近，延迟执行

* 可以很容易在Node.js中运行

### 缺点：

* 依赖SPM打包， 模块的加载逻辑偏重

### 实现：

* [Sea.js](http://seajs.org/docs/)

* [coolie](https://github.com/cooliejs/coolie.js)

## UMD

[Universal Module Definition](https://github.com/umdjs/umd) 规范类似于兼容CommonJS和AMD的语法，是模块定义的跨平台解决方案

## ES6模块

EcmaScript 6 标准增加了Javascript语言层面的模块定义。ES6模块设计的思想，是尽量的静态化，使得编译时就能确定模块的依赖关系，<br>
以及输入和输出的变量 。CommonJs和AMD模块，都只能在运行时确定这些东西。
```
import "jquery";
export function doStuff() {}
module "localModule" {}
```

### 优点：

* 容易进行静态分析

* 面向未来的EcmaScript的标准

### 缺点：

* 原生浏览器还没有实现该标准

* 全新的命令字，新版的Node.js才支持

### 实现：

* [Babel](https://babeljs.io/)

## 期望的模块系统

可以兼容多种模块风格，尽量可以利用已有的代码，不仅仅只是JavaScript模块化，还有CSS、图片、字体等 资源也需要模块化

## 前端模块加载

前端模块要在客户端中执行，所以他们需要增量加载到浏览器中。

模块的加载和传输，我们首先能想到两种极端的方式，一种是每个模块文件都单独请求，喂种是把所有的模块打包成一个文件然后只请求一次<br>
显而易见，每个模块都发起单独的请求赞成了请求次数过多，导致应用启动速度慢；一次请求加载所有模块导致流量浪费，初始化过程慢。<br>
这两种方式都不是好的解决方案，它们过于简单粗暴。

分块传输，按需进行懒加载，在实际用到某些模块的时候再增量更新，才是较为合理的模块加载方案。要实现模块的按需加载，就需要一个对整<br>
个代码库中的模块进行静态分析、编译打包的过程

## 所有资源都是模块

在上面分析过程中，我们提到的模块仅仅是指javascript 模块文件。然而，在前端开发过程中还涉及到样式、图片、字体、Html、模板等 <br>
众多的资源。这些资源还会以各种形式存在，比如：cooffeescript、less、sass、众多的模板库、多语言系统(i18n)等等。
```
require("./style.css");
require("./style.less");
require("./template.jade");
require("./image.png");
```

## 静态分析

在编译的时候，要对整个代码进行静态分析，分析出各个模块的类型和它们依赖关系，然后将不同类型的模块提交给适配的加载器来处理。比如一个用 LESS 写的样式模块，可以先用 LESS 加载器将它转成一个CSS 模块，在通过 CSS 模块把他插入到页面的 <style> 标签中执行。Webpack 就是在这样的需求中应运而生。

同时，为了能利用已经存在的各种框架、库和已经写好的文件，我们还需要一个模块加载的兼容策略，来避免重写所有的模块。

那么接下来，让我们开始 Webpack 的神奇之旅吧
