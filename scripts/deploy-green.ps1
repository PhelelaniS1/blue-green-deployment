Write-Host \"🚀 Deploying Green Environment...\" -ForegroundColor Green

# Deploy green backend
kubectl apply -f k8s/green/backend-deployment.yaml

# Wait for green to be ready
Write-Host \"⏳ Waiting for green deployment to be ready...\" -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l version=green --timeout=300s

# Switch traffic to green
Write-Host \"🔄 Switching traffic to green...\" -ForegroundColor Cyan
kubectl patch service backend-service -p '{\"spec\":{\"selector\":{\"version\":\"green\"}}}'

Write-Host \"✅ Green deployment completed and traffic switched!\" -ForegroundColor Green
Write-Host \"🌐 Current environment: GREEN\" -ForegroundColor Green
