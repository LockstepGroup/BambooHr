Class BambooHrServer {
    [string]$Subdomain
    [string]$UriPath
    [string]$ApiKey

    #region Tracking
    ########################################################################

    hidden [bool]$Connected
    [array]$UrlHistory
    [array]$RawQueryResultHistory
    [array]$QueryHistory
    $LastError
    $LastResult

    ########################################################################
    #endregion Tracking

    #region getApiUrl
    ########################################################################
    # Generate Api URL
    [String] getApiUrl() {
        if ($this.Subdomain) {
            $url = 'https://api.bamboohr.com/api/gateway.php/' + $this.Subdomain + '/v1' + $this.UriPath
            return $url
        } else {
            return $null
        }
    }

    ########################################################################
    #endregion getApiUrl

    #region createQueryString
    ########################################################################

    [string] createQueryString ([hashtable]$hashTable) {
        $QueryString = [System.Web.httputility]::ParseQueryString("")

        foreach ($Pair in $hashTable.GetEnumerator()) {
            switch ($Pair.Value.GetType().Name) {
                'DateTime' {
                    $Pair.Value = Get-Date -Date $Pair.Value -Format yyyy-MM-dd
                }
            }

            $QueryString[$($Pair.Name)] = $($Pair.Value)
        }

        return ("?" + $QueryString.ToString())
    }

    ########################################################################
    #endregion createQueryString

    #region processQueryResult
    ########################################################################

    [psobject] processQueryResult ($unprocessedResult) {
        return $unprocessedResult
    }

    ########################################################################
    #endregion processQueryResult

    #region invokeApiQuery
    ########################################################################

    [psobject] invokeApiQuery([hashtable]$queryString, [string]$method) {
        $url = $this.getApiUrl()

        # tracking
        $this.UrlHistory += $url
        $this.QueryHistory += $queryString

        # bamboo uses basic auth so we need to create a credential object
        # username: your apikey ($this.ApiKey)
        # password: x (always an x)
        $BasicAuthPassword = ConvertTo-SecureString 'x' -AsPlainText -Force
        $BasicAuthCredential = New-Object System.Management.Automation.PSCredential ($this.ApiKey, $BasicAuthPassword)

        # try query
        try {
            $QueryParams = @{}
            $QueryParams.Uri = $url
            $QueryParams.Uri += $this.createQueryString($queryString)
            <# switch ($method) {
                'PUT' {
                    $QueryParams.Uri += $this.createQueryString($queryString)
                }
                'POST' {
                    $QueryParams.Body = $this.createBodyString($queryString)
                }
            } #>
            <# if ($method -eq 'PUT') {
                $QueryParams.Uri += $this.createQueryString($queryString)
            } else {
                $QueryParams.Body = $this.createBodyString($queryString)
            } #>
            $QueryParams.Method = $method
            $QueryParams.Credential = $BasicAuthCredential
            $QueryParams.Authentication = 'Basic'
            <# $QueryParams.Headers = @{
                'Accept' = 'application/json'
            } #>

            $rawResult = Invoke-RestMethod @QueryParams
        } catch {
            Throw $_
        }

        $this.RawQueryResultHistory += $rawResult
        $this.LastResult = $rawResult

        $proccessedResult = $this.processQueryResult($rawResult)

        return $proccessedResult
    }

    ########################################################################
    #endregion invokeApiQuery

    #region Initiators
    ########################################################################

    # empty initiator
    BambooHrServer() {
    }

    ########################################################################
    #endregion Initiators
}
