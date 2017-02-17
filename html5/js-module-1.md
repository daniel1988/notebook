#Javascript模块化编程

## 模块的写法

### 1、原始写法

模块就是实现特定功能的一组方法。 只要把不同的函数简单地放一起，就算一个模块。
```
　　function m1(){
　　　　//...
　　}
　　function m2(){
　　　　//...
　　}
```

>上面的函数m1和m2，组成一个模块的时候，直接调用就行了。
这种做法缺点很明显：污染了全局变量，无法保证不与其它模块发生变量名冲突，而且模块成员之间看不出直接关系。

### 2、对象写法

```
　　var module1 = new Object({
　　　　_count : 0,
　　　　m1 : function (){
　　　　　　//...
　　　　},
　　　　m2 : function (){
　　　　　　//...
　　　　}
　　});
```

> 缺点：容易暴露所有模块成员，内部状态可以被外部改写，如：` module1.count = 2; `

### 3、立即执行函数写法

使用[立即执行函数写法](http://benalman.com/news/2010/11/immediately-invoked-function-expression/)Immediately-Invoked Function Expression (IIFE)
<br>
可以达到不暴露私有成员的目的
```
　　var module1 = (function(){
　　　　var _count = 0;
　　　　var m1 = function(){
　　　　　　//...
　　　　};
　　　　var m2 = function(){
　　　　　　//...
　　　　};
　　　　return {
　　　　　　m1 : m1,
　　　　　　m2 : m2
　　　　};
　　})();
```
> 缺点：无法读取内部_count变量 `console.info(module1._count); //undefined`

### 4、放大模式

如果一个模块很大，必须分成几个部分，或者一个模块需要继承另一个模块，这时就有必要采用“放大模式”

```
　　var module1 = (function (mod){
　　　　mod.m3 = function () {
　　　　　　//...
　　　　};
　　　　return mod;
　　})(module1);
```

### 5、宽放大模式（Loose augmentation）

在浏览器环境中，模块的各个部分通常都是从网上获取的，有时无法知道哪个部分会先加载，如果采用上面的写法，和一个执行<br>
部分有可能加载一个不存在空对象，这时就要采用“宽放大模式”
```
　　var module1 = ( function (mod){
　　　　//...
　　　　return mod;
　　})(window.module1 || {});
```
> 与"放大模式"相比，＂宽放大模式＂就是"立即执行函数"的参数可以是空对象。

### 6、输入全局变量

独立性是模块的重要特点，模块内部最好不与程序的其它部分直接交互。为了在模块内部调用全局变量，必须地将其它变量输入模块
```
　　var module1 = (function ($, YAHOO) {
　　　　//...
　　})(jQuery, YAHOO);
```
> 上面module1模块需要使用JQuery库和YUI库，就把这两个库（其实是两个模块）当作参数输入module1。这样做保证模块的独立性<br>
还使得模块之间的依赖关系变得明显