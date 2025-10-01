param(
    [string] = \"latest\",
    [string] = \"blue\"
)

Write-Host \"🐳 Building Docker Images (Tag: , Environment: )\" -ForegroundColor Cyan

# Build Backend Image
Write-Host \"Building Backend Image...\" -ForegroundColor Yellow
docker build -t phelelanis1/task-manager-backend: -f docker/backend/Dockerfile .

# Build Frontend Image  
Write-Host \"Building Frontend Image...\" -ForegroundColor Yellow
docker build -t phelelanis1/task-manager-frontend: -f docker/frontend/Dockerfile .

# Tag for blue/green deployment if specified
if ( -eq \"blue\" -or  -eq \"green\") {
    Write-Host \"Tagging for  environment...\" -ForegroundColor Green
    docker tag phelelanis1/task-manager-backend: phelelanis1/task-manager-backend:
}

Write-Host \"✅ Docker images built successfully!\" -ForegroundColor Green
Write-Host \"📦 Images created:\" -ForegroundColor White
Write-Host \"   - phelelanis1/task-manager-backend:\" -ForegroundColor White
Write-Host \"   - phelelanis1/task-manager-frontend:\" -ForegroundColor White
if ( -eq \"blue\" -or  -eq \"green\") {
    Write-Host \"   - phelelanis1/task-manager-backend:\" -ForegroundColor White
}
