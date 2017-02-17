const http = require('http');

const host = '127.0.0.1';

const port = 8889;

const server = http.createServer(function(req, res){
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/html');
    res.end('<h1>Hello World</h1>');
})

server.listen(port, function() {
    console.log('Server Running At http://%s:%s/', host, port);
});