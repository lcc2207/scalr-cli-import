#/bin/bash
# import via cli
export farmId=2795
export farmRoleId=4164
export userid=ubuntu

for instance in $(cat import_instances)
do
  # add instance to json file
  cat instance.json | jq '.cloudServerId="'$instance'"' > $instance.json
  # Import instances
  scalr-ctl farm-roles import-server --farmRoleId $farmRoleId --stdin < $instance.json
done

# get the deploy command from each instance
scalr-ctl farms list-servers --farmId $farmId | jq -r '.data[] | "\(.publicIp[0]),\(.scalrAgent.deployCommand)"' > deploy.txt

# ssh in
mkdir -p instances
while read LINE
do
 instance=$(echo $LINE | awk -F "," '{print $1}')
 run=$(echo $LINE | awk -F "," '{print $2}')
 echo $run
 echo  $run >  instances/$instance
done < deploy.txt

for inst in $(ls instances/)
do
 scp instances/$inst $userid@$inst:/tmp/run.sh
 ssh $userid@$inst 'chmod 755 /tmp/run.sh;sudo /tmp/run.sh'
done
