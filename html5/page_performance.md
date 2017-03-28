# 网页性能管理详解


## 网页生成过程

理解网页的性能为什么不好，得先了解网页是怎么生成的。大概分为五步：

* 1、HTML代码转化为DOM

* 2、CSS代码转化为CSSOM( CSS Object Model)

* 3、结合DOM和CSSOM，生成一棵渲染树（包含每个节点　的视觉信息）

* 4、生成布局(layout) ，即将所有渲染树的所有节点进行平面合成

* 5、将布局绘制(paint) 在屏幕上

![](http://www.ruanyifeng.com/blogimg/asset/2015/bg2015091501.png)

>这五步里面，第一步到第三步都非常快，耗时的是第四步与第五步



## 重排与重绘

网页生成的时候，至少会渲染一闪，用户访问的过程中，还会不断重新渲染。

以下三种情况会导致网页重新渲染

* 修改dom

* 修改样式表

* 用户事件（比如鼠标悬停、页面滚动、输入框键入文字、改变窗口大小等）

重新渲染，就需要重新生成布局和重新绘制，前者叫做重排（reflow），后者叫做重绘（repaint）

需要注意的是，重绘不一定需要重排，比如改变某个网页元素的顔色，只会触发重绘，不会触发重排，因为布局没有改变，
但是重排必然导致重绘，比如改变一个网页元素的位置，就会同时触发重排和重绘，因为布局改变了。


## 对于性能的影响

重排和重绘不断触发，这是不可避免的，但是它们非常耗费资源，是导致网页性能的根本原因。提高网页性能就是要降低
重排与重绘的频率和成本，尽量少触发重新渲染。

前面提到，dom变动和样式变动，都会触发重．但是，浏览器已经很智能了，会尽量把所有的变动集中在一起，排成一个队列，
然后一次性执行，尽量避免多次重新渲染。

```
div.style.color = 'blue';
div.style.marginTop = '20px';
```
> 上面的代码中，div元素有两个样式变动，但是浏览器只会触发一次重排与重绘

**如果写的不好就会触发两次重排和重绘

```
div.style.color = 'blue';
var margin = parseInt(div.style.marginTop);
div.style.marginTop = (margin + 10) + 'px';
```
> 上面的div设置背景后，第二行要求浏览器给出该元素的位置，所以浏览器不得不立即重排，一般来说，样式的写操作之后，
如果有下面这些属性读操作，都会引发浏览器的重新渲染
```
offsetTop/offsetLeft/offsetWidth/offsetHeight
scrollTop/scrollLeft/scrollWidth/scrollHeight
clientTop/clientLeft/clientWidth/clientHeight
getComputedStyle()
```

所以，从性能角度考虑，尽量不要把读操作和写操作，放在一个语句里面。
```
// bad
div.style.left = div.offsetLeft + 10 + "px";
div.style.top = div.offsetTop + 10 + "px";

// good
var left = div.offsetLeft;
var top  = div.offsetTop;
div.style.left = left + 10 + "px";
div.style.top = top + 10 + "px";
```


## 提高性能的九个技巧


* 第一条是上一节说到的，DOM 的多个读操作（或多个写操作），应该放在一起。不要两个读操作之间，加入一个写操作。

* 第二条，如果某个样式是通过重排得到的，那么最好缓存结果。避免下一次用到的时候，浏览器又要重排。

* 第三条，不要一条条地改变样式，而要通过改变class，或者csstext属性，一次性地改变样式。

* 第四条，尽量使用离线DOM，而不是真实的网面DOM，来改变元素样式。比如，操作Document Fragment对象，完成后再把这个对象加入DOM。再比如，使用 cloneNode() 方法，在克隆的节点上进行操作，然后再用克隆的节点替换原始节点。

* 第五条，先将元素设为display: none（需要1次重排和重绘），然后对这个节点进行100次操作，最后再恢复显示（需要1次重排和重绘）。这样一来，你就用两次重新渲染，取代了可能高达100次的重新渲染。

* 第六条，position属性为absolute或fixed的元素，重排的开销会比较小，因为不用考虑它对其他元素的影响。

* 第七条，只在必要的时候，才将元素的display属性为可见，因为不可见的元素不影响重排和重绘。另外，visibility : hidden的元素只对重绘有影响，不影响重排。

* 第八条，使用虚拟DOM的脚本库，比如React等。

* 第九条，使用 window.requestAnimationFrame()、window.requestIdleCallback() 这两个方法调节重新渲染（详见后文）。

[详情](http://www.ruanyifeng.com/blog/2015/09/web-page-performance-in-depth.html)