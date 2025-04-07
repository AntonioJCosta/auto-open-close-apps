param (
    [string]$ProcessToSearch,
    [string]$AppFullPath
)

if (-not $ProcessToSearch) {
    Write-Host "Error: 'ProcessToSearch' parameter is required." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $AppFullPath)) {
    Write-Host "Error: Application path '$AppFullPath' does not exist." -ForegroundColor Red
    exit 1
}

Write-Host "Searching for processes containing '$ProcessToSearch'..."
$processes = Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "*$ProcessToSearch*" }
Write-Host "Found $($processes.Count) process(es) containing '$ProcessToSearch'."

if ($processes) {
    Write-Host "Terminating $($processes.Count) process(es)..."
    $processes | Stop-Process -Force
    Write-Host "All processes containing '$ProcessToSearch' have been terminated."
    exit 0
} 

Write-Host "No processes containing '$ProcessToSearch' found."
Write-Host "Starting the application in the background..."
try {
    $outputLog = "$($env:TEMP)\$($ProcessToSearch)_out.log"
    $errorLog = "$($env:TEMP)\$($ProcessToSearch)_err.log"

    Start-Process -FilePath $AppFullPath -NoNewWindow -RedirectStandardOutput $outputLog -RedirectStandardError $errorLog
    Write-Host "'$ProcessToSearch' application has been started in the background."
    Write-Host "Logs: Output -> $outputLog, Error -> $errorLog"
    exit 0
} catch {
    Write-Host "Error: Failed to start the application. $_" -ForegroundColor Red
    exit 1
}