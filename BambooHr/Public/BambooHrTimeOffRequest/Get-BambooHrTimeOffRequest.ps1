function Get-BambooHrTimeOffRequest {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False)]
        [datetime]$StartDate = (Get-Date),

        [Parameter(Mandatory = $False)]
        [datetime]$EndDate = (Get-Date).AddDays(30)
    )

    BEGIN {
        $VerbosePrefix = "Get-BambooHrTimeOffRequest:"
        $ReturnObject = @()

        $QueryParams = @{}
        $QueryParams.UriPath = '/time_off/requests/'
        $QueryParams.Method = 'GET'
        $QueryParams.Query = @{}
        $QueryParams.Query.start = $StartDate
        $QueryParams.Query.end = $EndDate
    }

    PROCESS {
        $Query = Invoke-BambooHrApiQuery @QueryParams
        foreach ($entry in $Query.requests.request) {
            $New = New-BambooHrTimeOffRequest

            $New.EmployeeId = $entry.employee.id
            $New.EmployeeDisplayName = $entry.employee.'#text'
            $New.Start = $entry.start
            $New.End = $entry.end
            $New.Created = $entry.created
            $New.Status = $entry.status.'#text'
            $New.Type = $entry.type.'#text'

            foreach ($date in $entry.dates.date) {
                $NewDate = [BambooHrTimeOffDate]::new()
                $NewDate.Date = $date.ymd
                $NewDate.Amount = $date.amount

                $New.Date += $NewDate
            }


            $ReturnObject += $New
        }
    }

    END {
        $ReturnObject
    }
}
