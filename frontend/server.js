const http = require('http');

const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(
        <html>
            <head><title>Task Manager</title></head>
            <body>
                <h1>Task Manager Frontend</h1>
                <p>Environment: </p>
                <p>Backend URL: </p>
            </body>
        </html>
    );
});

const PORT = process.env.PORT || 8080;
server.listen(PORT, () => {
    console.log(Frontend server running on port );
});
