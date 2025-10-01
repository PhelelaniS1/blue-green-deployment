param(
    [string] = "docker",  # or hyperv, virtualbox
    [int] = "4096",
    [int] = 2,
    [switch] = True
)

Write-Host "🚀 Starting Minikube cluster..." -ForegroundColor Cyan

# Stop existing cluster if running
minikube stop

# Start Minikube with specified configuration
minikube start 
    --driver= 
    --memory= 
    --cpus= 
    --disk-size=20g 
    --addons=metrics-server 
    --addons=ingress 
    --addons=dashboard

if () {
    Write-Host "🔧 Setting up local registry..." -ForegroundColor Yellow
    minikube addons enable registry
}

# Configure Docker to use Minikube's Docker daemon
minikube docker-env | Invoke-Expression

Write-Host "✅ Minikube cluster started successfully!" -ForegroundColor Green
Write-Host "📊 Cluster Info:" -ForegroundColor White
minikube status
minikube node list

Write-Host "
🌐 Useful commands:" -ForegroundColor Cyan
Write-Host "   minikube dashboard          # Open Kubernetes dashboard" -ForegroundColor White
Write-Host "   minikube service list       # List all services" -ForegroundColor White
Write-Host "   minikube ip                 # Get cluster IP" -ForegroundColor White
Write-Host "   eval $(minikube docker-env) # Use Minikube's Docker daemon" -ForegroundColor White
