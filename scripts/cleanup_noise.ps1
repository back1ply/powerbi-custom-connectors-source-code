param(
    [string]$TargetDir = ".\connectors",
    [switch]$DryRun = $false
)

# 1. Resolve paths dynamically based on the script location 
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($ScriptPath)) { $ScriptPath = Get-Location }

$ResolvedTarget = if ([System.IO.Path]::IsPathRooted($TargetDir)) { $TargetDir } else { Join-Path $ScriptPath $TargetDir }

Write-Host "Cleaning up directory: $ResolvedTarget"

if (-not (Test-Path -Path $ResolvedTarget)) {
    Write-Error "Target directory not found: $ResolvedTarget. Please provide a valid path using -TargetDir."
    exit 1
}

# 2. Define exactly what IS safe to delete. 
# We want to KEEP: .pq, .m, .pqm, .json, .graphql, .txt, .md
$ExtensionsToDelete = @(
    ".resx",            # Localization strings
    ".png", ".jpg", ".jpeg", ".svg", # Icons
    ".rels", ".xml",    # Packaging metadata/manifests
    ".psdsxs", ".psdor" # Leftover developer visual assets
)

# 3. Get all files matching those extensions
$FilesToDelete = Get-ChildItem -Path $ResolvedTarget -File -Recurse | Where-Object { 
    $ext = $_.Extension.ToLower()
    $ExtensionsToDelete -contains $ext -or 
    $_.Name -eq "[Content_Types].xml" 
}

if ($FilesToDelete.Count -eq 0) {
    Write-Host "No unnecessary files found to clean up!" -ForegroundColor Green
    exit 0
}

Write-Host "Found $($FilesToDelete.Count) files that can be safely deleted to reduce context noise.`n"

# 4. Delete the files
$deletedCount = 0
foreach ($file in $FilesToDelete) {
    if ($DryRun) {
        Write-Host "[DRY RUN] Would delete: $($file.FullName)"
    }
    else {
        try {
            Remove-Item -Path $file.FullName -Force -ErrorAction Stop
            $deletedCount++
        }
        catch {
            Write-Warning "Failed to delete $($file.FullName): $_"
        }
    }
}

if (-not $DryRun) {
    Write-Host "Successfully deleted $deletedCount files." -ForegroundColor Green
    
    # 5. Clean up lingering empty folders like _rels
    $EmptyFolders = Get-ChildItem -Path $ResolvedTarget -Directory -Recurse | Where-Object { 
        (Get-ChildItem -Path $_.FullName -File -Recurse).Count -eq 0 
    }
    
    if ($EmptyFolders.Count -gt 0) {
        Write-Host "Removing $($EmptyFolders.Count) leftover empty directories..."
        foreach ($folder in $EmptyFolders) {
            Remove-Item -Path $folder.FullName -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "Done!"
