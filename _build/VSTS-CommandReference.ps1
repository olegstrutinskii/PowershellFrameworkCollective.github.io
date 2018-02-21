Write-Host "###############################################################"
Write-Host " - "
Write-Host "Importing Required modules"
Write-Host "  Importing PSFramework"
Import-Module PSFramework -Force
Write-Host "  Importing PSModuleDevelopment"
Import-Module PSModuleDevelopment -Force
Write-Host "  Importing PSUtil"
Import-Module PSUtil -Force
Write-Host " - "
Write-Host "###############################################################"
Write-Host " - "

$commandReferenceBasePath = "$($env:SYSTEM_DEFAULTWORKINGDIRECTORY)\documentation\commands"

#region PSFramework
$moduleName = "PSFramework"
$excludedCommands = @("New-PSFTeppCompletionResult")
Write-PSFMessage -Level Host -Message "Processing $moduleName"
Write-PSFMessage -Level Host -Message "  Creating list of commands to process"
$commands = Get-Command -Module $moduleName -CommandType Function | Select-Object -ExpandProperty Name | Where-Object { $_ -notin $excludedCommands } | Sort-Object
Write-PSFMessage -Level Host -Message "  $($commands.Count) commands found"

Write-PSFMessage -Level Host -Message "  Creating markdown help files"
Remove-Item "$($commandReferenceBasePath)\$($moduleName)" -Recurse -ErrorAction Ignore
$null = New-Item "$($commandReferenceBasePath)\$($moduleName)" -ItemType Directory
$null = New-MarkdownHelp -Command $commands -OutputFolder "$($commandReferenceBasePath)\$($moduleName)"

Write-PSFMessage -Level Host -Message "  Creating index file"
Set-Content -Path "$($commandReferenceBasePath)\$($moduleName).html" -Value @"
# $moduleName Command Reference

"@ -Encoding UTF8

foreach ($command in $commands)
{
	Add-Content -Path "$($commandReferenceBasePath)\$($moduleName).html" -Value " - [$command]($($moduleName)/$command.html)"
}
Write-PSFMessage -Level Host -Message "Finished processing $moduleName"
#endregion PSFramework

#region PSModuleDevelopment
$moduleName = "PSModuleDevelopment"
$excludedCommands = @()
Write-PSFMessage -Level Host -Message "Processing $moduleName"
Write-PSFMessage -Level Host -Message "  Creating list of commands to process"
$commands = Get-Command -Module $moduleName -CommandType Function | Select-Object -ExpandProperty Name | Where-Object { $_ -notin $excludedCommands } | Sort-Object
Write-PSFMessage -Level Host -Message "  $($commands.Count) commands found"

Write-PSFMessage -Level Host -Message "  Creating markdown help files"
Remove-Item "$($commandReferenceBasePath)\$($moduleName)" -Recurse -ErrorAction Ignore
$null = New-Item "$($commandReferenceBasePath)\$($moduleName)" -ItemType Directory
$null = New-MarkdownHelp -Command $commands -OutputFolder "$($commandReferenceBasePath)\$($moduleName)"

Write-PSFMessage -Level Host -Message "  Creating index file"
Set-Content -Path "$($commandReferenceBasePath)\$($moduleName).html" -Value @"
# $moduleName Command Reference

"@ -Encoding UTF8

foreach ($command in $commands)
{
	Add-Content -Path "$($commandReferenceBasePath)\$($moduleName).html" -Value " - [$command]($($moduleName)/$command.html)"
}
Write-PSFMessage -Level Host -Message "Finished processing $moduleName"
#endregion PSModuleDevelopment

#region PSUtil
$moduleName = "PSUtil"
$excludedCommands = @()
Write-PSFMessage -Level Host -Message "Processing $moduleName"
Write-PSFMessage -Level Host -Message "  Creating list of commands to process"
$commands = Get-Command -Module $moduleName -CommandType Function | Select-Object -ExpandProperty Name | Where-Object { $_ -notin $excludedCommands } | Sort-Object
Write-PSFMessage -Level Host -Message "  $($commands.Count) commands found"

Write-PSFMessage -Level Host -Message "  Creating markdown help files"
Remove-Item "$($commandReferenceBasePath)\$($moduleName)" -Recurse -ErrorAction Ignore
$null = New-Item "$($commandReferenceBasePath)\$($moduleName)" -ItemType Directory
$null = New-MarkdownHelp -Command $commands -OutputFolder "$($commandReferenceBasePath)\$($moduleName)"

Write-PSFMessage -Level Host -Message "  Creating index file"
Set-Content -Path "$($commandReferenceBasePath)\$($moduleName).html" -Value @"
# $moduleName Command Reference

"@ -Encoding UTF8

foreach ($command in $commands)
{
	Add-Content -Path "$($commandReferenceBasePath)\$($moduleName).html" -Value " - [$command]($($moduleName)/$command.html)"
}
Write-PSFMessage -Level Host -Message "Finished processing $moduleName"
#endregion PSUtil

Write-Host " - "
Write-Host "###############################################################"
Write-Host " - "

$branch = $env:BUILD_SOURCEBRANCHNAME
Write-PSFMessage -Level Host -Message "Applying documentation to repository"

git add .
git commit -m "VSTS Library Compile ***NO_CI***"
#$errorMessage = git push "https://$env:SYSTEM_ACCESSTOKEN@github.com/sqlcollaborative/dbatools.git" head:$branch 2>&1
#if ($LASTEXITCODE -gt 0) { throw $errorMessage }