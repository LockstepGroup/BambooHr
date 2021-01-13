function New-BambooHrServer {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "New-BambooHrServer:"
    }

    PROCESS {
        $ReturnObject = [BambooHrServer]::new()
    }

    END {
        $ReturnObject
    }
}
