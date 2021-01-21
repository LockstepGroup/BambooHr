function New-BambooHrTimeOffRequest {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "New-BambooHrTimeOffRequest:"
    }

    PROCESS {
        $ReturnObject = [BambooHrTimeOffRequest]::new()
    }

    END {
        $ReturnObject
    }
}
