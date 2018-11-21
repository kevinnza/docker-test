const Http = require('http');

const server = Http.createServer((req, res) => {
  const body = 'Server is working okay';

  res.writeHead(200, {
    'Content-Length': Buffer.byteLength(body),
    'Content-Type': 'text/plain'
  });

  res.end(body);
});

server.listen(3000, () => {
    console.log('Test server listening...');
});
