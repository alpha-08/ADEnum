function Import-ActiveDirectory
{

    [CmdletBinding()] Param(
        [Parameter(Position = 0, Mandatory = $False)]
        [String]
        $ActiveDirectoryModule
    )

    $retVal = Get-Module -ListAvailable | where { $_.Name -eq "ActiveDirectory" }
    if ($retVal) {
        Import-Module ActiveDirectory
    } else {
        if($ActiveDirectoryModule) {
            $path = Resolve-Path $ActiveDirectoryModule
            $DllBytes = [IO.File]::ReadAllBytes($path)
        } else {
            [Byte[]] $DllBytes = $Data -split ' '
        }
        
        $Assembly = [System.Reflection.Assembly]::Load($DllBytes)
        Import-Module -Assembly $Assembly
    }
}