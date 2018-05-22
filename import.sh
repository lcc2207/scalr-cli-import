#/bin/bash
# import via cli
export farmRoleId=xxxx

for instance in $(cat import_instances)
do
  # add instance to json file
  cat instance.json | jq '.cloudServerId="'$instance'"' |jq ".role.id=$farmRoleId" > $instance.json
  # Import instances
  scalr-ctl farm-roles import-server --farmRoleId $farmRoleId --stdin < $instance.json
done
