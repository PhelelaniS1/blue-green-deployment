param(
    [string] = \"patch\"  # patch, minor, major
)

# Read current version from package.json
try {
    \ = Get-Content -Raw -Path \"backend/package.json\" | ConvertFrom-Json
    \ = Get-Content -Raw -Path \"frontend/package.json\" | ConvertFrom-Json
    \ = \.version
} catch {
    Write-Host \"⚠️  No existing package.json found, starting with version 1.0.0\" -ForegroundColor Yellow
    \ = \"1.0.0\"
}

Write-Host \"Current Version: \\" -ForegroundColor Yellow

# Bump version
\ = \.Split('.')
switch (\) {
    \"major\" { 
        \[0] = [int]\[0] + 1
        \[1] = 0
        \[2] = 0
    }
    \"minor\" { 
        \[1] = [int]\[1] + 1
        \[2] = 0
    }
    \"patch\" { 
        \[2] = [int]\[2] + 1
    }
}

\ = \ -join '.'
Write-Host \"New Version: \\" -ForegroundColor Green

# Create/Update package.json files if they don't exist
if (-not (Test-Path \"backend/package.json\")) {
    \ = @{
        name = \"task-manager-backend\"
        version = \
        description = \"Task Manager Backend API\"
        main = \"server.js\"
        scripts = @{
            start = \"node server.js\"
            dev = \"nodemon server.js\"
        }
    }
    \ | ConvertTo-Json -Depth 10 | Out-File -FilePath \"backend/package.json\" -Encoding utf8
}

if (-not (Test-Path \"frontend/package.json\")) {
    \ = @{
        name = \"task-manager-frontend\"
        version = \
        description = \"Task Manager Frontend\"
        scripts = @{
            start = \"next start\"
            dev = \"next dev\"
            build = \"next build\"
        }
    }
    \ | ConvertTo-Json -Depth 10 | Out-File -FilePath \"frontend/package.json\" -Encoding utf8
}

# Update Kubernetes deployments with new version
if (Test-Path \"k8s/blue/backend-deployment.yaml\") {
    \ = Get-Content -Raw -Path \"k8s/blue/backend-deployment.yaml\"
    \ = \ -replace \"blue-[\\d\\.]+\", \"blue-\\"
    \ | Out-File -FilePath \"k8s/blue/backend-deployment.yaml\" -Encoding utf8
}

if (Test-Path \"k8s/green/backend-deployment.yaml\") {
    \ = Get-Content -Raw -Path \"k8s/green/backend-deployment.yaml\" 
    \ = \ -replace \"green-[\\d\\.]+\", \"green-\\"
    \ | Out-File -FilePath \"k8s/green/backend-deployment.yaml\" -Encoding utf8
}

Write-Host \"✅ Version bumped to \!\" -ForegroundColor Green
Write-Host \"📝 Next steps:\" -ForegroundColor Cyan
Write-Host \"   1. Build images: .\\scripts\\docker-build.ps1 -ImageTag \\" -ForegroundColor White
Write-Host \"   2. Push images: .\\scripts\\docker-push.ps1 -ImageTag \\" -ForegroundColor White
Write-Host \"   3. Deploy: .\\scripts\\deploy-green.ps1\" -ForegroundColor White
