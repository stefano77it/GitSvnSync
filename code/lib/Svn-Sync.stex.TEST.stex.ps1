<# 
Copyright 2015 Stefano Spinucci, mail virgo977virgo at gmail dot com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. #>

# SET Environment configuration (from   https://tiredblogger.wordpress.com/2009/08/21/using-git-and-everything-else-through-powershell/ )
# Add Git executables to the mix.
#[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";" + (Join-Path $pathToPortableGit "\bin") + ";" + $scripts, "Process")
[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path)
# Setup Home so that Git doesn't freak out.
[System.Environment]::SetEnvironmentVariable("HOME", (Join-Path $Env:HomeDrive $Env:HomePath), "Process")

$MyDocsPath = [Environment]::GetFolderPath("mydocuments")$date = Get-Date -format "yyyyMMddHHmmss"
$LogFilePath = $MyDocsPath + '\' + 'Sync-Repos-Log.' + $date + '.log.txt'
"#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####" >> $LogFilePath



# Log a message to file LogFilePath
function LogAppend()
{
    param (
    [string]$LogFilePath = $(throw "-LogFilePath is required."), 
    [string]$CommandToLog = $(throw "-CommandToLog is required."), 
    [string]$CommandDescriptionToLog = $(throw "-CommandDescriptionToLog is required."), 
    $CommandOutputToLog = $(throw "-CommandOutputToLog is required.")
    )
    & $PSScriptRoot'.\lib-Log-Append.stex.ps1' -LogFilePath $LogFilePath -CommandToLog $CommandToLog -CommandDescriptionToLog $CommandDescriptionToLog -CommandOutputToLog $CommandOutputToLog
}



# Pause execution
function Pause()
{
param (
    [string]$PauseMessage = ""   # optional
)
    & $PSScriptRoot'.\lib-Pause.stex.ps1' -PauseMessage $PauseMessage
}




$Action = "Verify"
$WkPath = "C:\Users\Stefano\Desktop\vcs sample, svn repo + wk\repo bare BAK.svn"
$BareRepoPath =""
$CommitMessage = ""
$Unattended = "True"

& $PSScriptRoot'.\Svn-Sync.stex.ps1' -Action $Action -WkPath $WkPath -BareRepoPath $BareRepoPath -LogFilePath $LogFilePath -CommitMessage $CommitMessage -Unattended $Unattended



. pause -PauseMessage "END of script`n"

