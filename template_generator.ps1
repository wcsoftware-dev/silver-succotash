# Template Generator Script

Write-Host "Welcome to the Template Generator!" -ForegroundColor Green

# Save the starting directory
$startingDir = Get-Location

# Ensure the generic template directory exists
$genericTemplateDir = Join-Path -Path $startingDir -ChildPath "generic_template"
if (-Not (Test-Path -Path $genericTemplateDir)) {
    Write-Host "Error: Generic template directory '$genericTemplateDir' does not exist." -ForegroundColor Red
    Set-Location -Path $startingDir
    exit
}

# Step 1: List available template types
$availableTemplates = Get-ChildItem -Path $genericTemplateDir -Attributes Directory | Select-Object -ExpandProperty Name
if (-Not $availableTemplates -or $availableTemplates.Count -eq 0) {
    Write-Host "Error: No templates found in '$genericTemplateDir'." -ForegroundColor Red
    Set-Location -Path $startingDir
    exit
}

Write-Host "Available template types:" -ForegroundColor Cyan
$availableTemplates | ForEach-Object { Write-Host "- $_" }

# Step 2: Ask for template type
$templateType = Read-Host "What type of template would you like to create"

# Step 3: Ask for project name
$projectName = Read-Host "Enter the name of your project"

# Step 4: Ask for destination directory
$destinationDir = Read-Host "Enter the destination directory"

# Validate destination directory
if (-Not (Test-Path -Path $destinationDir)) {
    Write-Host "The directory '$destinationDir' does not exist. Creating it now..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $destinationDir | Out-Null
}

# Define the generic template directory
$genericTemplateDir = Join-Path -Path $startingDir -ChildPath "generic_template"

if (-Not (Test-Path -Path $genericTemplateDir)) {
    Write-Host "Error: Generic template directory '$genericTemplateDir' does not exist." -ForegroundColor Red
    exit
}

# Step 5: Copy the selected template type to the destination
$templateDir = Join-Path -Path $genericTemplateDir -ChildPath $templateType
if (-Not (Test-Path -Path $templateDir)) {
    Write-Host "Error: Template type '$templateType' does not exist in '$genericTemplateDir'." -ForegroundColor Red
    exit
}

$projectDir = Join-Path -Path $destinationDir -ChildPath $projectName
Copy-Item -Path $templateDir -Destination $projectDir -Recurse

# Step 6: Replace placeholders in the copied files
Get-ChildItem -Path $projectDir -Recurse -File | ForEach-Object {
    $filePath = $_.FullName
    $content = Get-Content -Path $filePath -Raw

    # Replace placeholder with project name in file content
    $content = $content -replace "{{PROJECT_NAME}}", $projectName

    Set-Content -Path $filePath -Value $content
}

# Step 6.1: Replace placeholders in file names
Get-ChildItem -Path $projectDir -Recurse -File | ForEach-Object {
    $filePath = $_.FullName
    $fileName = $_.Name

    if ($fileName -match "{{PROJECT_NAME}}") {
        $newFileName = $fileName -replace "{{PROJECT_NAME}}", $projectName
        $newFilePath = Join-Path -Path $_.DirectoryName -ChildPath $newFileName
        Rename-Item -Path $filePath -NewName $newFilePath
    }
}

# Step 7: Initialize a git repository and commit the files
Set-Location -Path $projectDir
if (-Not (Test-Path -Path (Join-Path -Path $projectDir -ChildPath ".git"))) {
    git init | Out-Null
    git add .
    git commit -m "Initial Commit." | Out-Null
    Write-Host "Initialized a new git repository and committed the files." -ForegroundColor Green
} else {
    Write-Host "Git repository already exists in the target directory." -ForegroundColor Yellow
}

# Step 8: Notify the user
Write-Host "Template '$templateType' has been successfully created at '$projectDir'." -ForegroundColor Green

# Return to the starting directory
Set-Location -Path $startingDir