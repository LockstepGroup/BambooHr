Class BambooHrEmployee {
    [int]$Id

    [string]$DisplayName
    [string]$FirstName
    [string]$LastName
    [string]$PreferredName
    [string]$Gender
    [string]$JobTitle
    [string]$WorkPhone
    [string]$MobilePhone
    [string]$WorkEmail
    [string]$Department
    [string]$WorkPhoneExtension
    [bool]$PhotoUploaded
    [string]$PhotoUrl
    [bool]$CanUploadPhoto

    #region Initiators
    ########################################################################

    # empty initiator
    BambooHrEmployee() {
    }

    ########################################################################
    #endregion Initiators
}
