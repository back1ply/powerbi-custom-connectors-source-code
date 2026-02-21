param(
    [string]$TargetDir = ".\connectors",
    [switch]$IncludeFiles = $false
)

# 1. Resolve paths dynamically based on the script location 
# If $TargetDir is relative, resolve it relative to where the script is currently located
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
# If running interactively, $ScriptPath might be empty, so fallback to current directory
if ([string]::IsNullOrWhiteSpace($ScriptPath)) { $ScriptPath = Get-Location }

$ResolvedTarget = if ([System.IO.Path]::IsPathRooted($TargetDir)) { $TargetDir } else { Join-Path $ScriptPath $TargetDir }

Write-Host "Scanning directory for extensions: $ResolvedTarget"

# 2. Check if Target exists
if (-not (Test-Path -Path $ResolvedTarget)) {
    Write-Error "Target directory not found: $ResolvedTarget. Please provide a valid path using -TargetDir."
    exit 1
}

# 3. Get all files recursively
$AllFiles = Get-ChildItem -Path $ResolvedTarget -File -Recurse

if ($AllFiles.Count -eq 0) {
    Write-Warning "No files found in the directory!"
    exit 0
}

Write-Host "Found $($AllFiles.Count) total files.`n"

# 4. Group by extension
$GroupedExtensions = $AllFiles | Group-Object Extension | Sort-Object Count -Descending

if ($IncludeFiles) {
    # Provide a detailed list mapping each extension to its files
    foreach ($group in $GroupedExtensions) {
        $ext = if ([string]::IsNullOrWhiteSpace($group.Name)) { "[No Extension]" } else { $group.Name }
        Write-Host "=== Extension: $ext ($($group.Count) files) ===" -ForegroundColor Cyan
        $group.Group | Select-Object -ExpandProperty FullName | ForEach-Object { Write-Host "  $_" }
        Write-Host ""
    }
}
else {
    # Provide a summary table
    Write-Host "Summary of file extensions found:" -ForegroundColor Green
    $GroupedExtensions | Select-Object @{Name = "Extension"; Expression = { if ([string]::IsNullOrWhiteSpace($_.Name)) { "[No Extension]" } else { $_.Name } } }, Count | Format-Table -AutoSize
}

Write-Host "Done!"
