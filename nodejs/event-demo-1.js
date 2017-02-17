//引入模块
var events = require('events');

var eventEmitter = new events.EventEmitter();

var connectHandle = function connected() {
    console.log( 'connected successed !' );
    eventEmitter.emit('data_received');
}


eventEmitter.on('connection', connectHandle);

eventEmitter.on('data_received', function(){
    console.log('data receive success');
})

eventEmitter.emit('connection');

console.log( 'Over' );



var fs = require("fs");

fs.readFile('input.txt', function (err, data) {
   if (err){
      console.log(err.stack);
      return;
   }
   console.log(data.toString());
});
console.log("程序执行完毕");