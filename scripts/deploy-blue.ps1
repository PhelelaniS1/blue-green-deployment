Write-Host \"🚀 Deploying Blue Environment...\" -ForegroundColor Green

# Deploy blue backend
kubectl apply -f k8s/blue/backend-deployment.yaml

# Wait for blue to be ready
Write-Host \"⏳ Waiting for blue deployment to be ready...\" -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l version=blue --timeout=300s

# Switch traffic to blue
Write-Host \"🔄 Switching traffic to blue...\" -ForegroundColor Cyan
kubectl patch service backend-service -p '{\"spec\":{\"selector\":{\"version\":\"blue\"}}}'

Write-Host \"✅ Blue deployment completed and traffic switched!\" -ForegroundColor Green
Write-Host \"🌐 Current environment: BLUE\" -ForegroundColor Blue
