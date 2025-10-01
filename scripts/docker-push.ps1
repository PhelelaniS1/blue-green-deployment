param(
    [string] = \"latest\"
)

Write-Host \"🚀 Pushing Docker Images to Registry...\" -ForegroundColor Cyan

# Login to Docker Hub (you'll need to set DOCKERHUB_PASSWORD as env variable)
# docker login -u phelelanis1 -p \

Write-Host \"Pushing Backend Image...\" -ForegroundColor Yellow
docker push phelelanis1/task-manager-backend:

Write-Host \"Pushing Frontend Image...\" -ForegroundColor Yellow  
docker push phelelanis1/task-manager-frontend:

# Push blue/green tags if they exist
if (docker image inspect phelelanis1/task-manager-backend:blue 2>) {
    docker push phelelanis1/task-manager-backend:blue
    Write-Host \"Pushed blue tag\" -ForegroundColor Blue
}

if (docker image inspect phelelanis1/task-manager-backend:green 2>) {
    docker push phelelanis1/task-manager-backend:green
    Write-Host \"Pushed green tag\" -ForegroundColor Green
}

Write-Host \"✅ All images pushed successfully!\" -ForegroundColor Green
