# scalr-cli-import

This is an example script of how to use the Scalr-cli to import instances

## Prerequisite
- An agentless role
- A pre-made agentless farm role that will be used to import servers into

## For AWS Imports

Get the instace ID from the AWS console or CLI and create a file named
* import_instances

#Contents examples:
<table>
  <tr>
    <td><tt>i-asdfsadfa</tt></td>
  </tr>
  <tr>
    <td><tt>i-xasdfasdd</tt></td>
  </tr>
</table>

#### copy the instance file over
- Copy the ec2-instances.json to instance.json
- Make sure to update the contents of the file to match your environment 

#### Update line below in the "import.sh" script with the actual farm role ID that the servers will be impprted into
* export farmRoleId=xxxx

#### Execute
```
./import.sh
```


## For VMWare Imports

Get the instace ID from the VCenter or the PowerCLI and create a file named
* import_instances

#Contents examples:
<table>
  <tr>
    <td><tt>vm-123</tt></td>
  </tr>
  <tr>
    <td><tt>vm-124</tt></td>
  </tr>
</table>


#### copy the instance file over
- copy the vmware-instances.json to instance.json
- Make sure to update the contents of the file to match your environment 

#### Update line below in the "import.sh" script with the actual farm role ID that the servers will be impprted into
* export farmRoleId=xxxx

#### Execute
```
./import.sh
```

## VMware Notes

You can use the PowerCLI to obtain the vm-xxx id numbers

PowerCLI:
```
$vcenter = Connect-viserver fqdnforVC -User userid -Password xxx <br />
get-vm | ForEach-Object {$_.ExtensionData.Moref.Value} | Out-File imports <br />
```

** if you want to get the name of the instaces - but you will need to remove the name 
row before running!!<br />
```
get-vm | ForEach-Object {$_.Name + ", " + $_.ExtensionData.Moref.Value} | Out-File imports
```

## Migrating Servers After Importing
If you would like to migrate a server after it has been imported you can run the following script on the Scalr server:
```
/opt/scalr-server/embedded/bin/php /opt/scalr-server/embedded/scalr/app/bin/move-server.php --server-ids=ID1,ID2,ID3 --farm-role-id=YYYY
```
IMPORTANT:
- Servers must be agentless to migrate
- Servers can only be migrated within the same environment
