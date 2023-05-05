# Get the names of all the directories and write them to a Hash Table (in case any new ones get added)
# Write out numbered list of OS system choices based on above
# Request user input (select number) to determine the OS desired
# Depending on the OS selected; navigate to the desired directory
# Get the list of all available plugins that can be used for the OS (get unique prefixes)
# Write out numbered list of OS system choices based on above
# Request user input (select number) to determine the plugin desired
# Get the list of all available OS variants for the plugin

$osTypes = @{
    CentOS = 'CentOS'
    Kali   = 'Kali Linux'
    Oracle  = 'Oracle Linux'
    RHEL = 'Red Hat Linux'
    Ubuntu   = 'Ubuntu'
    Windows = 'Windows'
}
$osIndex = 0
$osTypes.keys | ForEach-Object{
    $message = '{0} : {1}' -f $osIndex, $osTypes[$_]
    Write-Output $message
    $osIndex = $osIndex + 1
}