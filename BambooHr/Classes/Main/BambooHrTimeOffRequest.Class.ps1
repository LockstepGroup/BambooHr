Class BambooHrTimeOffDate {
    [datetime]$Date
    [int]$Amount

    #region Initiators
    ########################################################################

    # empty initiator
    BambooHrTimeOffDate() {
    }

    ########################################################################
    #endregion Initiators
}


Class BambooHrTimeOffRequest {
    [int]$EmployeeId
    [string]$EmployeeDisplayName
    [datetime]$Start
    [datetime]$End
    [datetime]$Created
    [string]$Status
    [string]$Type
    [BambooHrTimeOffDate[]]$Date

    #region Initiators
    ########################################################################

    # empty initiator
    BambooHrTimeOffRequest() {
    }

    ########################################################################
    #endregion Initiators
}
