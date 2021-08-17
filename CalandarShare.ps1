Using module "./Logging.psm1"
Using module "./HelperMethods.psm1"
Using module "./AuthenticationHelpers.psm1"

function Login-Office365 {
    param (
    )
    $config = Read-ConfigFile
    $o365Creds = Get-O365Credentials -username $config.o365User -password $config.o365UserPW
    Connect-Office365 -credentials $o365Creds
}

function Share-Calendar {
    param (
        $Mailbox
    )
    $calname = Get-MailboxFolderStatistics -Identity $Mailbox.DistinguishedName -FolderScope calendar | where-object {$_.FolderType -eq "Calendar"}
    $calendar = $Mailbox.Alias + ":\" + $calname.Name.toString()
    Write-Host $calendar

    # Setting everyone to have Reviewer access to the calendar
    Set-MailboxFolderPermission -identity $calendar -AccessRights Reviewer -User Default
    
    ## If you want to add more permissions, like edit access for specific users, do it here.
    ## Example: Add editor permission to example-user (replace 'example-user') so s(he) can edit the contents of the calendar
    # Add-MailboxFolderPermission -identity $calendar -AccessRights Editor -User example-user
}

function Main {

    # Logging
    SetUpLogs
    $ErrorActionPreference="SilentlyContinue"
    Stop-Transcript | out-null
    $ErrorActionPreference = "Continue"
    Start-Transcript -path $global:LogFileName -append


    Login-Office365

    $Mailboxes = Get-Mailbox -Resultsize Unlimited
    foreach ($Mailbox in $Mailboxes) {
        # Write-Host $Mailbox
        Share-Calendar -Mailbox $Mailbox
    }

    # Stop logging
    Stop-Transcript
}

Main
