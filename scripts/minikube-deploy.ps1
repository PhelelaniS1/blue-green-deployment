param(
    [string] = "blue"
)

Write-Host "🎯 Deploying to Minikube ( environment)..." -ForegroundColor Cyan

# Set Docker to use Minikube's daemon
minikube docker-env | Invoke-Expression

# Build images directly in Minikube
Write-Host "🐳 Building images in Minikube..." -ForegroundColor Yellow
.\scripts\docker-build.ps1 -ImageTag "minikube-test" -Environment 

# Apply Kubernetes configurations
Write-Host "📦 Applying Kubernetes configurations..." -ForegroundColor Yellow

# Deploy base services (mongodb, redis)
kubectl apply -f k8s/mongodb-deployment.yaml
kubectl apply -f k8s/redis-deployment.yaml
kubectl apply -f k8s/mongodb-service.yaml  
kubectl apply -f k8s/redis-service.yaml

# Deploy specified environment
if ( -eq "blue") {
    kubectl apply -f k8s/blue/
} else {
    kubectl apply -f k8s/green/
}

# Deploy frontend and ingress
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml
kubectl apply -f k8s/ingress.yaml

Write-Host "✅ Deployment completed!" -ForegroundColor Green
Write-Host "
📊 Checking deployment status..." -ForegroundColor Cyan
kubectl get pods -o wide
kubectl get services

Write-Host "
🌐 Access points:" -ForegroundColor Cyan
minikube service list
