#!/bin/sh
echo $HOSTNAME
Type=`echo $HOSTNAME | awk -F'-' '{print $1}'`
Cluster=`echo $HOSTNAME | awk -F'-' '{print $2}'`
Role=`echo $HOSTNAME | awk -F'-' '{print $3}' | sed 's/\..*//'`
echo "Cluster: $Cluster"
echo "Role: $Role"
if [ -z "$Role" ]; then
        exit
else
        echo "Has Role"
        mkdir -p /opt/tmp/
        yum -y install mesos-ansible
        echo [$Cluster] > '/opt/tmp/host'
        echo '127.0.0.1' >> '/opt/tmp/host'
        echo [$Role] >> '/opt/tmp/host'
        echo '127.0.0.1' >> '/opt/tmp/host'
        /usr/bin/ansible-playbook -i /opt/tmp/host -c local /opt/tmp/main.yml
fi

