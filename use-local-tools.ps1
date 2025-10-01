# Add local tools to PATH temporarily
$env:PATH = "$env:PATH;$PSScriptRoot\tools"

# Now you can use minikube and kubectl normally
minikube version
kubectl version --client

Write-Host "✅ Local tools are ready to use!" -ForegroundColor Green
Write-Host "💡 Use this script before running any minikube/kubectl commands" -ForegroundColor Yellow
