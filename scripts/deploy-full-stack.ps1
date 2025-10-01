Write-Host \"🚀 Deploying Complete Blue-Green Stack...\" -ForegroundColor Green

# Deploy databases
Write-Host \"Deploying Databases...\" -ForegroundColor Yellow
kubectl apply -f k8s/mongodb-pvc.yaml
kubectl apply -f k8s/mongodb-deployment.yaml
kubectl apply -f k8s/mongodb-service.yaml
kubectl apply -f k8s/redis-deployment.yaml
kubectl apply -f k8s/redis-service.yaml

# Deploy blue environment (default)
Write-Host \"Deploying Blue Environment...\" -ForegroundColor Blue
kubectl apply -f k8s/blue/backend-deployment.yaml

# Deploy frontend
Write-Host \"Deploying Frontend...\" -ForegroundColor Yellow
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml

# Deploy services
Write-Host \"Deploying Services...\" -ForegroundColor Yellow
kubectl apply -f k8s/backend-service.yaml

# Deploy nginx
Write-Host \"Deploying Nginx Load Balancer...\" -ForegroundColor Yellow
kubectl apply -f k8s/nginx-configmap.yaml
kubectl apply -f k8s/nginx-deployment.yaml
kubectl apply -f k8s/nginx-service.yaml

Write-Host \"✅ Complete stack deployed!\" -ForegroundColor Green
Write-Host \"⏳ Waiting for services to be ready...\" -ForegroundColor Yellow

# Wait for services
Start-Sleep -Seconds 10

Write-Host \"🌐 Application should be available soon via LoadBalancer\" -ForegroundColor Cyan
Write-Host \"📊 Check status with: kubectl get all\" -ForegroundColor White
