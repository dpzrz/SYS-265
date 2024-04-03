# Network Storage Project - IPFS

## What is IPFS?
* IPFS (InterPlanetary File System) is a decentralized protocol designed to create a peer-to-peer method of storing and sharing hypermedia in a distributed file system.
* It aims to make the web faster, safer, and more open by replacing the traditional client-server model with a distributed one.
## Networking
* We will be using the follow machines:
* * MGMT01-name (10.0.5.10)
* * WKS01-name (10.0.5.100)
* * Docker01-name (10.0.5.12)
### Topology
* This is a peer-to-peer topology, meaning that the devices are all connected to each other, creating a mesh.

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/1e079388-2b6f-4858-b1f8-c58b9909fd68)


## Download IPFS
### Windows
* Go to the [IPFS download page](https://github.com/ipfs/ipfs-desktop/releases) and download the latest release of the IPFS Desktop Setup
* Run the installer and choose the following options:
* * Only allow the current user (the -adm account) to run the IPFS software

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/a45bf90d-d7a2-4060-9d1e-3cc97daf94af)

* * Choose the location you want for the destination folder (default is fine)

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/2548253c-3632-4db0-bc22-5e53e2f17d45)

* * Then Finally Install the program
### Linux (Ubuntu)
* Go to [IPFS Kubo download page](https://docs.ipfs.tech/install/command-line/)
* First grab the latest wget package:
* * The one used in the Installation demo was `wget https://dist.ipfs.tech/kubo/v0.27.0/kubo_v0.27.0_linux-amd64.tar.gz`
* With the file downloaded to the system it should look something like this:

<img width="821" alt="image" src="https://github.com/dpzrz/SYS-265/assets/112894794/3393d54f-61e9-4af7-ae9e-159a2e60ee05">

* To unzip the file you can use the tar command: `tar -xvzf kubo_v0.27.0_linux-amd64.tar.gz`
* After this is done a folder titled `kubo` should be extracted and you must then `cd` into tthat folder.
* You'll have to run the install script once inside the kubo directory. This command is `sudo bash install.sh`:

<img width="821" alt="image" src="https://github.com/dpzrz/SYS-265/assets/112894794/796c0163-3eeb-44e9-94a5-1885f45e4a35">

* You can check version number by executing the command `ipfs --version` inside the kubo directory.
* To initialize the server you have to run two commands `ipfs init`, this command will generate the RSA keys adn perform other validation. The output of this command wll look something like this:
```
> initializing ipfs node at /Users/diego/.ipfs
> generating 2048-bit RSA keypair...done
> peer identity: Qmcpo2iLBikrdf1d6QU6vXuNb6P7hwrbNPW9kLAH8eG67z
> to get started, enter:
>
>   ipfs cat /ipfs/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG/readme
```
* once this is done you can run the daemon in the kubo directory by executing `ipfs daemon`. This will start youre IPFS server and provide you with running logs and detailed info.
## Uploading and Pinning Files
* First Create a new text file that you want to upload using notepad.exe for Windows and vi/nano for Linux (**Remember its filepath**)

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/9fd0dc42-ce97-483e-a2ad-d1460145c2c9)

### Windows
* To Upload a File or Folder to IPFS, go to the Files tab and then select Import:

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/63e365ed-4912-499f-9be1-60cda08c7e0a)

* Go to the File Path of the file you just created and then select open:

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/5ce8083c-4cc2-4607-89b7-1ed449763789)

* Once the file has been uploaded, click on the three dots and select "Set Pinning" and choose to Pin it on the local node then hit "Apply":

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/9cd5c5a5-016b-4e98-809d-19550dca852d)


## Sharing Files 
### Windows
* There are two ways to share a file: One is through a link and the other its content identifiers (CID)
#### Link
* Go to the three dots and select "Share Link", then copy the URL given

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/e97e84e7-a198-4032-a0cf-182622508035)

* Then you can go to a web browser and access the file through it

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/08166aeb-3131-41a1-b1e5-07873cd19a78)

#### CID
* On the node with the file, go to the three dots and select "Copy CID"
* Then go to the other node and select "Import" and then "From IPFS"
* Through some means copy the CID to the import screen and you may choose a name for the file, if you don't the name will be the CID

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/e1aaa4e6-e83d-43fa-95ac-992b3436af92)

* Import the File and you should see it in the files section:

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/f96445bb-6e05-40a1-a34e-62bf0aa257f2)

* You can now go to the three dots and select "Download" to download the file and view its contents

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/345a8dd9-50eb-4fbf-8fa9-2e7257c85381)

## Centralization with Pinata
* You can use the Pinning Service Pinata to centralize your CIDs into one management system rather than managing them on each individual node
### Account Creation
* Go to [Pinata](https://www.pinata.cloud/) and create a free account
* Login and select "I'm not a developer, I'll use the web app", select the free plan, select 'Other" for the questions and select "Build on"
* The initial page should look something like this:

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/c148f82c-d4ef-4988-be81-5100fbc84e4d)

### Connecting Pinata to the IPFS Nodes
* To connect your IPFS nodes to the Pinata API, you need to create an API key for the node and allow their IP addresses through
#### API key
* In Pinata, go to 'API keys" tab under "Developers" and then select "New Key"
* Create an admin key with unlimited uses, name it "SYS265", then generate the key
* A window will pop up with an API key, API Secret, and Secret Access Token (JWT) **MAKE SURE TO TAKE NOTE OF THE INFORMATION AND COPY THE SECRET TOKEN BEFORE CLOSING THAT TAB, IT ONLY APPEARS ONCE PER KEY CREATION**
* You should now see the key in your API keys tab:

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/46d3fcd4-c4ab-4bd9-ac9c-ac5d55c13640)

#### IP Addresses
* In Pinata, go to the "Access Controls" tab under "Developers" and then select "Set IP Address"
* Enter the IP Address for the device you want to have access to Pinata and then select "Set IP Address"
* Repeat this process for each node's IP address

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/89980cff-400a-4e6f-80a9-dd2485b59cb0)

#### Connecting them together
* Now go to the IPFS node and go to "Settings" and find "Pinning Services"
* Select "Add Service" and then choose Pinata
* Paste the Secret Access Token from earlier and then select "Save"

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/aebf1e08-34c2-4e57-8d01-0287b51f0bb4)

* It should now be listed under Pinning Services

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/fb7f2710-844a-4e15-a910-b6a0cc130cb2)

* Now if you go back to the file you created, go to the three dots and select "Set Pinning", you should now see Pinata as an option, select it and hit "Apply":

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/74082be2-95a1-4962-aec2-2e6d395200c8)

* Now if you check Pinata, you should see the File there along with the Log of the Pinning Process at the bottom

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/26cb4aca-9974-4d8c-bfb2-68c65b7dddbd)

### Automatic Updates
* You can configure the Pinata Pinning Service on IPFS to automatically update Pinata on all the pinned files located on that node
* Go to Settings and go to "Pinning Services"
* Find Pinata and go to the three dots, then select "Enable Auto Upload"

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/79103fb3-02e9-4898-9df1-207a499d9cfb)

* Once completed it will look like this

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/7bb999b1-7243-4b27-99c8-b0ea184647c2)

* Create a new file and upload it to IPFS and it should automatically be pinned at Pinata
* The File will be named "policy/..." so I would recommend changing the name afterwards 

![image](https://github.com/eamonstackpole/my-tech-journal/assets/113706361/26c707af-742e-49be-aeb7-751b722913fd)

## Test Script
* After configuring IPFS, do the following:
* * Create a folder on one of the devices named SYS265
* * Insert an Image file and text file into the folder
* * Upload the folder to its IPFS Node
* * Copy the CID of the folder and use it to acquire the folder on the other node
* * Download from the other node, extract the download file, and check the folder and files within
* * Check Pinata for the Automatically uploaded folder

## Reflection
Overall, this process tested the docuemntation aspect of isntallation. There were multiple ways of installing IPFS and these solutions involved varying degrees of challenge. There was an untested docker installation that seemd promising but while diving deeper into the documentatiosn resluted in mnay compatability issues. The group aspect of this assignment was beneficial for the spreading out of workloads. My teammates proved helpful.

## Sources
* [IPFS Documentation](https://docs.ipfs.tech/install/)
