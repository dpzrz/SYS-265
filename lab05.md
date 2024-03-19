# AD Group Policy & SW Deployment
In this lab were diving back into Orginaztional Units and using them to deploy sostfware throughout our domain. This lab utilizes GUI and CLI interfaces. This lab also refrences a prevoius lab on OU's, along with a lab on network shares.

## Wokring With Orginizational Units
To create an OU you can use thhe Active Directory and Computers program through our server manager. This is a GUI tat allows authorized users to create, move, and change OU's and other things. To add an OU thriugh this service you can simply righgt click the side folder area and click new Organzational Unit. This works on our `mgmnt01` box but were tasked to complete this through powershell on `ad01`.

### Powershell OU Configuration

#### Adding an OU

This command is realtivley simple, The command uses `New-ADOrganizationalUnit`. With the name of our OU Software Deploy and the domain name.local. The command will look like this.

`New-ADOrganizationalUnit -Name "Software Deploy" -Path "OU=name.local,DC=name,DC=local"`

#### Moving items into an OU

#### Deleting an OU 

The first cmdlet we’ll use, `Get-ADOrganizationlUnit`, identifies the specific OU and holds it in memory.

The second cmdlet, `Set-ADObject`, removes the flag for "Protect object from accidental deletion". This is imprtant because when we created the OU it automatically enabled this flag which protects against deletion.

The final cmdlet, `Remove-ADOrganizationalUnit`, deletes the OU and suppresses any confirmation prompts. The ‘-PassThru‘ switch tells the final cmdlet to reference the object already specified (our OU).

Combinin these commands using the `|` will look something like this.

`Get-ADOrganizationalUnit -identity "OU=Software Deploy,DC=diego,DC=local" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru | Remove-ADOrganizationalUnit -Confirm:$false`

## GPO Installation and Deployment

## Logs and Event Viewing
