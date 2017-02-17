var fs = require('fs');
var file = 'test.log';

// 同步阻塞
var data = fs.readFileSync(file);
console.log(data.toString());
console.log('program is Over');

//异步非阻塞
fs.readFile(file, function(err, data){
    if ( err ) {
        return console.error(err);
    }

    console.log( data.toString() ) ;
})

console.log('program is Over');