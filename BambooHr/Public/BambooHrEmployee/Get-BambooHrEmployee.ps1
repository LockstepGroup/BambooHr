function Get-BambooHrEmployee {
    [CmdletBinding()]
    Param (
    )

    BEGIN {
        $VerbosePrefix = "Get-BambooHrEmployee:"
        $ReturnObject = @()

        $QueryParams = @{}
        $QueryParams.UriPath = '/employees/directory'
        $QueryParams.Method = 'GET'
    }

    PROCESS {
        $Query = Invoke-BambooHrApiQuery @QueryParams
        foreach ($entry in $Query.directory.employees.employee) {
            $New = New-BambooHrEmployee
            $New.Id = $entry.id
            $New.DisplayName = ($entry.field | ? { $_.id -eq 'displayName' }).'#text'
            $New.FirstName = ($entry.field | ? { $_.id -eq 'firstName' }).'#text'
            $New.LastName = ($entry.field | ? { $_.id -eq 'lastName' }).'#text'
            $New.PreferredName = ($entry.field | ? { $_.id -eq 'preferredName' }).'#text'
            $New.Gender = ($entry.field | ? { $_.id -eq 'gender' }).'#text'
            $New.JobTitle = ($entry.field | ? { $_.id -eq 'jobTitle' }).'#text'
            $New.WorkPhone = ($entry.field | ? { $_.id -eq 'workPhone' }).'#text'
            $New.MobilePhone = ($entry.field | ? { $_.id -eq 'mobilePhone' }).'#text'
            $New.WorkEmail = ($entry.field | ? { $_.id -eq 'workEmail' }).'#text'
            $New.Department = ($entry.field | ? { $_.id -eq 'department' }).'#text'
            $New.WorkPhoneExtension = ($entry.field | ? { $_.id -eq 'workPhoneExtension' }).'#text'
            $New.PhotoUploaded = ($entry.field | ? { $_.id -eq 'photoUploaded' }).'#text'
            $New.PhotoUrl = ($entry.field | ? { $_.id -eq 'photoUrl' }).'#text'

            if (($entry.field | ? { $_.id -eq 'canUploadPhoto' }).'#text' -eq 'yes') {
                $New.CanUploadPhoto = $true
            }

            $ReturnObject += $New
        }
    }

    END {
        $ReturnObject
    }
}
