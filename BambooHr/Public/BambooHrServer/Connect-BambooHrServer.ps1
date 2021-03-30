function Connect-BambooHrServer {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$Subdomain = $global:BambooHrSubdomain,

        [Parameter(Mandatory = $false)]
        [string]$ApiKey = $global:BambooHrApiKey
    )

    BEGIN {
        $VerbosePrefix = "Connect-BambooHrServer:"
    }

    PROCESS {
        $ReturnObject = New-BambooHrServer
        $ReturnObject.Subdomain = $Subdomain
        $ReturnObject.ApiKey = $ApiKey
        #TODO: need to add a test connection
    }

    END {
        $Global:BambooHrServer = $ReturnObject
    }
}
