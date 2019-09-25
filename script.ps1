#define variables
$appSetup = "setup.exe"
$silent =" /S /V/qn"
$Source = "C:\temp\npp.7.7.1.Installer.exe"
$TimeFormat = 'yyyy/MM/dd hh:mm:ss tt'
 
#create event log source
new-eventlog -Logname Application -source $Source -ErrorAction `
SilentlyContinue
$logstamp = (get-date).toString($TimeFormat) ; $logstamp + `
" Created event log source.">>log.txt
 
#install application
Clear-Host
Write-Host "Starting Setup..."
cmd /c ($appSetup + $silent)
$logstamp = (get-date).toString($TimeFormat) ; $logstamp + `
" Launched setup.exe.">>log.txt
$logstamp = (get-date).toString($TimeFormat) ; $logstamp + `
" Exit code: " + $LastExitCode>>log.txt
 
If ($LastExitCode -eq 0) {
 
#write event log
Clear-Host
Write-Host "Writing event log..."
$startTime = Get-date
$startLog = 'Notepad++ COMPLETED SUCCESSFULLY ' `
+ $startTime
Write-Eventlog -Logname Application -Message $startLog -Source `
$Source -id 777 -entrytype Information -Category 0
$logstamp = (get-date).toString($TimeFormat) ; $logstamp + `
" Installed successfully!">>log.txt
 
#exiting
Clear-Host
Write-Host "Installed successfully! Exiting now..."
Start-Sleep -s 4
$logstamp = (get-date).toString($TimeFormat) ; $logstamp + `
" Exiting...">>log.txt
}
 
Else
 
{
#write event log
Clear-Host
Write-Host "Writing event log..."
$startTime = Get-date
$startLog = 'Notepad++ FAILED SETUP ' + $startTime
Write-Eventlog -Logname Application -Message $startLog `
-Source $Source -id 777 -entrytype Information -Category 0
$logstamp = (get-date).toString($TimeFormat) ; $logstamp `
 + " Failed setup!">>log.txt
 
#exiting
Clear-Host
Write-Host "Failed setup! Exiting now..."
Start-Sleep -s 4
$logstamp = (get-date).toString($TimeFormat) ; $logstamp + `
" Exiting...">>log.txt
}