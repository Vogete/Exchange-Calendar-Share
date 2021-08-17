function Get-O365Credentials {
    param (
        [string]$username,
        [string]$password
    )
    $secureStringPwd = ConvertTo-SecureString -String $password -AsPlainText -Force
    $creds = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd
    return $creds
}

function Connect-Office365 {
    param (
        [System.Management.Automation.PSCredential]$credentials
    )
    try {
        # EX Online V1 module:
        # # Does not support 2FA!
        # $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credentials -Authentication Basic -AllowRedirection
        # # Import-PSSession -Session $Session -DisableNameChecking -AllowClobber
        # Import-Module (Import-PSSession $Session -AllowClobber) -Global

        # EX Online V2
        Connect-ExchangeOnline -Credential $credentials -ShowProgress $False

    }
    catch {
        return $false;
    }
    
}

