Write-Host "🚀 Setting up Minikube with local tools..." -ForegroundColor Cyan

# Add tools to PATH
$env:PATH = "$env:PATH;$PSScriptRoot\tools"

# Start Minikube
.\tools\minikube.exe start --driver=docker --memory=4096 --cpus=2

Write-Host "✅ Minikube started successfully!" -ForegroundColor Green
Write-Host "
📊 Cluster Info:" -ForegroundColor White
.\tools\minikube.exe status

Write-Host "
🌐 Access your cluster:" -ForegroundColor Cyan
Write-Host "   .\tools\minikube.exe dashboard" -ForegroundColor White
Write-Host "   .\tools\minikube.exe ip" -ForegroundColor White
