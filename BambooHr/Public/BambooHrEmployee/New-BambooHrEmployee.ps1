function New-BambooHrEmployee {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "New-BambooHrEmployee:"
    }

    PROCESS {
        $ReturnObject = [BambooHrEmployee]::new()
    }

    END {
        $ReturnObject
    }
}
