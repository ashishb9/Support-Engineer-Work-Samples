# Collect-Logs.ps1
# Purpose: Collects Windows Event Logs, Service Status, and System Info for troubleshooting
# Author: Ashish (Support Engineer)

# Create timestamped output folder
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outputPath = "C:\SupportLogs_$timestamp"
New-Item -ItemType Directory -Path $outputPath -Force | Out-Null

Write-Output "Collecting logs... Output folder: $outputPath"

# Export Event Logs (System + Application)
wevtutil epl System "$outputPath\System.evtx"
wevtutil epl Application "$outputPath\Application.evtx"

# Export last 200 error events for quick view
Get-EventLog -LogName System -EntryType Error -Newest 200 | Out-File "$outputPath\SystemErrors.txt"
Get-EventLog -LogName Application -EntryType Error -Newest 200 | Out-File "$outputPath\AppErrors.txt"

# Collect running services list
Get-Service | Sort-Object Status | Out-File "$outputPath\Services.txt"

# Collect system info
systeminfo | Out-File "$outputPath\SystemInfo.txt"

# Copy custom app logs if path exists
$logSource = "C:\Logs\App"
if (Test-Path $logSource) {
    Copy-Item "$logSource\*" -Destination $outputPath -Recurse
}

# Compress results
$zipFile = "$outputPath.zip"
Compress-Archive -Path $outputPath -DestinationPath $zipFile -Force

Write-Output "Logs and system info collected. Archive created: $zipFile"
