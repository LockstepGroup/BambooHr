function Invoke-BambooHrApiQuery {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$UriPath,

        [Parameter(Mandatory = $false)]
        [hashtable]$Query = @{},

        [Parameter(Mandatory = $false)]
        [string]$Method = 'GET'
    )

    BEGIN {
        $VerbosePrefix = "Invoke-BambooHrApiQuery:"
    }

    PROCESS {
        if (-not $Global:BambooHrServer) {
            Throw "$VerbosePrefix no active connection to BambooHr, please use Connect-BambooHrServer to get started."
        } else {
            $Global:BambooHrServer.UriPath = $UriPath
            $ReturnObject = $Global:BambooHrServer.invokeApiQuery($Query, $Method)
        }
    }

    END {
        $ReturnObject
    }
}