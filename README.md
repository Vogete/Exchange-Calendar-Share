# Automatic Exchange Online Calendar Sharing

By default Microsoft Exchange (both online and server) makes all users' calendar private, so employees can't see what kind of events other people have. While this behavior works for a lot of companies, I've heard a lot of cases where managers (or other employees) asked their coworkers to share their calendars with them. Even so, lots of places straight up ask employees to share their calendars on their starting day, and lots of people have troubles, or refuse to do it. If you are struggling with the same issue, and want to centrally open up the users' calendars for each other, this is the script for you! 

_Why didn't Microsoft provide a feature that automatically shares calendars inside your tenant? Well.......I don't know. But at least we can solve it together!_

## Requirements

A user that has at least `Recipient Management` role group in Exchange Online is required to run the script, otherwise it can't modify the Exchange objects. If you want to limit it even further, the `Mail Recipients` Role should be the one that you need, but this might require you to set up a custom role group.

You'll need to have [Exchange Online PowerShell V2](https://docs.microsoft.com/en-us/powershell/exchange/exchange-online-powershell-v2) installed (`ExchangeOnlineManagement`) in order to run the code.

A `config.json` file that contains the credentials for this user:

```json
{
    "o365User": "username@domain.com",
    "o365UserPW": "password"
}
```

## Usage

If you have everything preconfigured and available (remember the config file!), you can just run the `CalendarShare.ps1` script, and it will go through all available mailboxes in your Exchange tenant, and share its primary calendar (which is what most people use anyway).

The heart of this script is the `Set-MailboxFolderPermission` PowerShell command, so it's super simple in its core. This means, you can also use `Add-MailboxFolderPermission` if you want more users to have special access (like editing access) to all calendars in your tenant.