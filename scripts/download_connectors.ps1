param(
    [Parameter(Mandatory)]
    [string]$TargetDir
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$manifestUrl = 'https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/manifest.json'
$manifest = Invoke-RestMethod -Uri $manifestUrl
$packages = @($manifest.extensions | Group-Object fileName | ForEach-Object {
    $_.Group | Sort-Object { [version]$_.version } -Descending | Select-Object -First 1
})
if ($packages.Count -eq 0) {
    throw 'The certified connector manifest contains no packages.'
}
if (Test-Path -LiteralPath $TargetDir) {
    throw "Download directory already exists: $TargetDir. Use a new directory to avoid mixing package sets."
}
New-Item -ItemType Directory -Path $TargetDir | Out-Null
foreach ($package in $packages) {
    if ([IO.Path]::GetFileName($package.fileName) -ne $package.fileName -or
        [IO.Path]::GetExtension($package.fileName) -notin '.pqx', '.mez') {
        throw "Invalid package filename in manifest: $($package.fileName)"
    }
    $uri = [Uri]$package.url
    if ($uri.Scheme -ne 'https' -or $uri.Host -ne 'content.prod.powerquery.microsoft.com') {
        throw "Unexpected package URL in manifest: $uri"
    }
    Write-Host "Downloading $($package.fileName) ($($package.version))"
    Invoke-WebRequest -Uri $uri -OutFile (Join-Path $TargetDir $package.fileName)
}
Write-Host "Downloaded $($packages.Count) certified connectors to $TargetDir"
