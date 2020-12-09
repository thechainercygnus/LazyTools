Get-ChildItem *.ps1 -Path .\Public,.\Private -Recurse | ForEach-Object {. $_.FullName}
Get-ChildItem *.ps1 -Path .\Public -Recurse | ForEach-Object {Export-ModuleMember $_.BaseName}