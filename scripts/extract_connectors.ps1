param(
    [string]$SourceDir = "$env:LOCALAPPDATA\Microsoft\Power BI Desktop Store App\CertifiedExtensions",
    [string]$TargetDir = ".\connectors",
    [switch]$KeepZips = $false
)

# 1. Resolve paths
$ResolvedSource = if ([System.IO.Path]::IsPathRooted($SourceDir)) { $SourceDir } else { Join-Path (Get-Location) $SourceDir }
$ResolvedTarget = if ([System.IO.Path]::IsPathRooted($TargetDir)) { $TargetDir } else { Join-Path (Get-Location) $TargetDir }

Write-Host "Source Directory: $ResolvedSource"
Write-Host "Target Directory: $ResolvedTarget"

# 2. Check if Source exists
if (-not (Test-Path -Path $ResolvedSource)) {
    Write-Error "Source directory not found: $ResolvedSource. Please check if Power BI Desktop is installed from the Store, or provide the correct path using -SourceDir."
    exit 1
}

# 3. Create Target directory if it doesn't exist
if (-not (Test-Path -Path $ResolvedTarget)) {
    New-Item -ItemType Directory -Force -Path $ResolvedTarget | Out-Null
    Write-Host "Created target directory: $ResolvedTarget"
}

# 4. Get all .pqx and .mez files
$files = Get-ChildItem -Path $ResolvedSource -Include *.pqx, *.mez -Recurse
if ($files.Count -eq 0) {
    Write-Warning "No .pqx or .mez files found in $ResolvedSource."
    exit 0
}

Write-Host "Found $($files.Count) connector files. Starting extraction..."

# 5. Load .NET Zip abstraction
Add-Type -AssemblyName System.IO.Compression.FileSystem

foreach ($file in $files) {
    # Remove the .pqx or .mez extension to get the clean connector name
    $connectorName = $file.Name -replace '\.pqx$', '' -replace '\.mez$', ''
    $destinationFolderPath = Join-Path -Path $ResolvedTarget -ChildPath $connectorName

    Write-Host "Processing $connectorName..."

    # Create the folder for this extension
    if (-not (Test-Path -Path $destinationFolderPath)) {
        New-Item -ItemType Directory -Force -Path $destinationFolderPath | Out-Null
    }

    # Copy the raw archive (optional, good for having the original binary)
    if ($KeepZips) {
        Copy-Item -Path $file.FullName -Destination $destinationFolderPath -Force
    }

    # Extract the contents using .NET ZipFile (handles the files without renaming extensions)
    try {
        # Check if it has already been extracted (simple heuristic: are there files inside?)
        $existingFiles = Get-ChildItem -Path $destinationFolderPath
        if ($existingFiles.Count -gt 0 -and -not $KeepZips) {
             # Write-Verbose "Already extracted $connectorName. Skipping..."
             # We can optionally clear it or just skip. Let's force overwrite by catching exceptions or clearing.
        }

        # ZipFile::ExtractToDirectory throws an exception if files exist, so we either clear the directory or extract manually.
        # Safest approach for a fresh run: Remove all files inside the destination folder first (excluding the copied zip if restricted)
        Get-ChildItem -Path $destinationFolderPath | Where-Object { $_.Name -ne $file.Name } | Remove-Item -Recurse -Force
        
        [System.IO.Compression.ZipFile]::ExtractToDirectory($file.FullName, $destinationFolderPath)
        Write-Host "  -> Successfully extracted $connectorName" -ForegroundColor Green
    } catch {
        Write-Warning "  -> Failed to extract $connectorName. Error: $_"
    }
}

Write-Host "Extraction complete! All connectors have been extracted to $ResolvedTarget" -ForegroundColor Cyan
