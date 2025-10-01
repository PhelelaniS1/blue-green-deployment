const http = require('http');
const url = require('url');

const server = http.createServer(async (req, res) => {
    const parsedUrl = url.parse(req.url, true);
    
    // Set CORS headers
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    
    if (req.method === 'OPTIONS') {
        res.writeHead(200);
        res.end();
        return;
    }
    
    if (parsedUrl.pathname === '/health') {
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            status: 'OK',
            service: 'frontend',
            timestamp: new Date().toISOString()
        }));
        return;
    }
    
    // Main frontend page
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(\
        <!DOCTYPE html>
        <html>
            <head>
                <title>Task Manager</title>
                <style>
                    body { 
                        font-family: Arial, sans-serif; 
                        margin: 40px;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                    }
                    .container { 
                        max-width: 800px; 
                        margin: 0 auto;
                        background: rgba(255,255,255,0.1);
                        padding: 30px;
                        border-radius: 10px;
                        backdrop-filter: blur(10px);
                    }
                    h1 { color: #fff; }
                    .status { 
                        padding: 10px; 
                        margin: 10px 0; 
                        border-radius: 5px;
                        background: rgba(255,255,255,0.2);
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>🚀 Task Manager Application</h1>
                    <div class="status">
                        <strong>Frontend Status:</strong> ✅ Running
                    </div>
                    <div class="status">
                        <strong>Environment:</strong> \
                    </div>
                    <div class="status">
                        <strong>Backend URL:</strong> \
                    </div>
                    <div class="status">
                        <strong>Deployment:</strong> Blue-Green Ready 🎯
                    </div>
                    <p>Your blue-green deployment infrastructure is successfully running!</p>
                </div>
            </body>
        </html>
    \);
});

const PORT = process.env.PORT || 8080;
server.listen(PORT, '0.0.0.0', () => {
    console.log(\✅ Frontend server running on port \\);
});
