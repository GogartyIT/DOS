# Prompt for credentials

$credential = Get-Credential -Message "Message for users*"
 
# Specify the credentials for connecting to the other domain

$username = $credential.UserName

$password = $credential.GetNetworkCredential().Password

#$domain = "<Domain Name"
 
# Define drive mappings

$driveMappings = @{
#example drives
    "R" = "\\jimgogarty.com\data"

    "v" = "\\192.168.0.11\data"

}
 
# Map network drives

foreach ($driveLetter in $driveMappings.Keys) {

   $uncPath = $driveMappings[$driveLetter]

  $null = New-PSDrive -Name $driveLetter -PSProvider FileSystem -Root $uncPath -Credential $credential -Persist -scope global

}
 
# Wait for a moment to ensure the drives are mapped before refreshing explorer

Start-Sleep -Seconds 5
 
# Refresh explorer to show mapped drives

$shell = New-Object -ComObject Shell.Application

$shell.Namespace(17).Self.InvokeVerb("Refresh")
 
Write-Host "Network drives mapped successfully and visible in File Explorer.
