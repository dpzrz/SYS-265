# AD Group Policy & SW Deployment
In this lab were diving back into Orginaztional Units and using them to deploy sostfware throughout our domain. This lab utilizes GUI and CLI interfaces. This lab also refrences a prevoius lab on OU's, along with a lab on network shares.

## Wokring With Orginizational Units
To create an OU you can use thhe Active Directory and Computers program through our server manager. This is a GUI tat allows authorized users to create, move, and change OU's and other things. To add an OU thriugh this service you can simply righgt click the side folder area and click new Organzational Unit. This works on our `mgmnt01` box but were tasked to complete this through powershell on `ad01`.

### Powershell OU Configuration

#### Adding an OU

This command is realtivley simple, The command uses `New-ADOrganizationalUnit`. With the name of our OU Software Deploy and the domain name.local. The command will look like this.

`New-ADOrganizationalUnit -Name "Software Deploy" -Path "OU=name.local,DC=name,DC=local"`

#### Moving items into an OU

We have to move two items into our newly created OU. We have to move a computer and a user. We use similar syntax to our last command. We establish a target path and use `Get-Computer` to obtain the info on WKS01-DIEGO. 

`Get-Computer WKS01-DIEGO | Move-ADObject -TargetPath 'OU=Software Deploy,DC=diego.local,DC=local'`

To move a User into Software Deploy we use the same command with some minor tweaks. We need to use `Get-ADUser` to obtain the proper user and `-Identity` to specify which user.

`Get-ADUser -Identity diego.perez | Move-ADObject -TargetPath 'OU=Software Deploy,DC=diego.local,DC=local'`

#### Deleting an OU 

The first cmdlet we’ll use, `Get-ADOrganizationlUnit`, identifies the specific OU and holds it in memory.

The second cmdlet, `Set-ADObject`, removes the flag for "Protect object from accidental deletion". This is imprtant because when we created the OU it automatically enabled this flag which protects against deletion.

The final cmdlet, `Remove-ADOrganizationalUnit`, deletes the OU and suppresses any confirmation prompts. The ‘-PassThru‘ switch tells the final cmdlet to reference the object already specified (our OU).

Combinin these commands using the `|` will look something like this.

`Get-ADOrganizationalUnit -identity "OU=Software Deploy,DC=diego,DC=local" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru | Remove-ADOrganizationalUnit -Confirm:$false`

## GPO Installation and Deployment

In this section well be creating a Group deployment policy and workflow. Before we start this we need to create a network share. Using the File Server service we can create a new share on mgmt01. This network share will ouse our `.msi` file for PuTTy. This share should be accessible from a regular account.

To use our Group Policy Management you might have to install the feature on `mgmnt01`. To install go to the Add Roles and Features dropdown and choose `mgmnt` Look through the fatures until you find Group Policy Management then ust follow the rest of the wizard.

To utilize the new fature we open up our tools menu and click Group Policy Management. Under our Software Deploy OU we can create a policy named Deploy SW. By edditing this poplicy we can add a package to be deployed. Chose the PuTTy.msi install from the network share we created earlier.

On our `Wks01` machine we need to run `gupdate /force`. This will restart our machine. After this our software will be insatlled on the machine.

## Logs and Event Viewing

To confirm and view our new install we use the built-in tool Event Viewer. I created a filter for Group Policy Managment events and found the logged info in Application tab.

To achieve this in Powershell we use the base command `Get-EventLog`. To specify the log name we use `-LogName`. Using our GUI info we can take the Event ID and use to to find the exact log, this is done by using `InstanceID`.

`Get-EventLog -LogName Application -InstanceID 119`
