[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$packageId = 'junegunn.fzf'
$beginMarker = '# >>> fzf integration >>>'
$endMarker = '# <<< fzf integration <<<'

$block = @"
$beginMarker
# Ctrl+T (files), Ctrl+R (history), **<Tab> (fuzzy completion)
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
    Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
}
$endMarker
"@

# 1. fzf
if (-not (Get-Command fzf.exe -ErrorAction SilentlyContinue)) {
    if (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) {
        throw 'WinGet is not installed. Install or update App Installer from the Microsoft Store, then rerun this script.'
    }

    Write-Host 'Installing fzf from the WinGet community repository...'
    winget.exe install --id $packageId --exact --source winget --silent `
        --accept-package-agreements --accept-source-agreements

    if ($LASTEXITCODE -ne 0) {
        throw "fzf installation failed with WinGet exit code $LASTEXITCODE."
    }
}
else {
    Write-Host 'fzf is already installed.'
}

# 2. PSFzf module
if (-not (Get-Module -ListAvailable -Name PSFzf)) {
    Write-Host 'Installing the PSFzf PowerShell module...'
    Install-Module -Name PSFzf -Scope CurrentUser -Repository PSGallery -Force
}
else {
    Write-Host 'PSFzf is already installed.'
}

# 3. PowerShell 7 profile (resolved via Documents so OneDrive Known Folder Move is handled)
$profilePath = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'PowerShell\Microsoft.PowerShell_profile.ps1'
$profileDir = Split-Path -Parent $profilePath
if (-not (Test-Path -LiteralPath $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}
if (-not (Test-Path -LiteralPath $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

$content = Get-Content -LiteralPath $profilePath -Raw
if ($null -eq $content) { $content = '' }

$markerPattern = '(?s)' + [regex]::Escape($beginMarker) + '.*?' + [regex]::Escape($endMarker)
if ($content -match $markerPattern) {
    $content = [regex]::Replace($content, $markerPattern, { param($m) $block })
    Write-Host "Updated fzf block in $profilePath"
}
else {
    $psReadLineImport = '(?m)^Import-Module -Name PSReadLine[^\r\n]*\r?\n'
    if ($content -match $psReadLineImport) {
        $content = [regex]::Replace($content, $psReadLineImport, { param($m) $m.Value + "`r`n$block`r`n" }, 1)
    }
    else {
        $content = "$block`r`n`r`n$content"
    }
    Write-Host "Added fzf block to $profilePath"
}

Set-Content -LiteralPath $profilePath -Value $content -NoNewline -Encoding UTF8

Write-Host 'fzf setup complete. Open a new PowerShell session to use Ctrl+T, Ctrl+R and **<Tab>.'
