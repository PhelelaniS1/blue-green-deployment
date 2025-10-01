param(
    [string] = "green"  # or blue
)

Write-Host "🔄 Switching traffic to  environment..." -ForegroundColor Cyan

# Update ingress to point to the specified backend
 = Get-Content -Path "k8s/ingress.yaml" -Raw

if ( -eq "green") {
     =  -replace "serviceName: backend-blue","serviceName: backend-green"
     =  -replace "blue","green"
} else {
     =  -replace "serviceName: backend-green","serviceName: backend-blue" 
     =  -replace "green","blue"
}

 | Out-File -FilePath "k8s/ingress.yaml" -Encoding utf8

# Apply the updated ingress
kubectl apply -f k8s/ingress.yaml

Write-Host "✅ Traffic switched to  environment!" -ForegroundColor Green

# Verify the switch
Write-Host "
🔍 Verification:" -ForegroundColor Cyan
kubectl get ingress
kubectl describe ingress task-manager-ingress

Write-Host "
📊 Current backend endpoints:" -ForegroundColor White
kubectl get endpoints
