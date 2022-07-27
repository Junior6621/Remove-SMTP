# Output will be added to c;\temp folder. open the Remove-SMTP-Address.log with a text editor. For example, Notepad.
Start-Transcript -Path C:\temp\Remove-SMTP-address.log -append

# Get all mailboxes
$Mailboxes = Get-Mailbox -resultSize Unlimited

# Loop through each mailbox
foreach ($Mailbox in $mailboxes) {

    # Change @contoso.com to the domain that you want to remove
    $mailbox.emailAddresses | Where-Object { ($_ -clike "smtp*") -and ($_ -like "*@removeme.local") } | 

    # Perform operation on each item
    forEach-Object {

        # Remove the -whatif parameter after you tested and are sure to remove the secondary email addresses
        Set-Mailbox $Mailbox.DistinguishedName -EmailAddresses @{remove = $_ } -WhatIf

        # Write output
        write-Host "Removing $_ from $Mailbox Mailbox" -Foregroundcolor Green
    }
}

Stop-Transcript
