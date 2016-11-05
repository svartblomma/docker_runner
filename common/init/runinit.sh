#!/bin/sh
#copy ansible code to host folder
cp -R /common/* /host
Type=`echo $HOSTNAME | awk -F'-' '{print $1}'`
Role=`echo $HOSTNAME | awk -F'-' '{print $2}' | sed 's/\..*//'`
echo "Role: $Role"
#add role to ansible host file
if [ -z "$Role" ]; then
        exit
else
        echo "[dockerdeploy]" > '/host/host'
        echo '127.0.0.1' >> '/host/host'
        echo [$Role] >> '/host/host'
        echo '127.0.0.1' >> '/host/host'
fi
