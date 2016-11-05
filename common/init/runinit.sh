#!/bin/sh
cp -R /common/* /host
echo $HOSTNAME
Type=`echo $HOSTNAME | awk -F'-' '{print $1}'`
Role=`echo $HOSTNAME | awk -F'-' '{print $2}' | sed 's/\..*//'`
echo "Role: $Role"
if [ -z "$Role" ]; then
        exit
else
        echo "Has Role"
        echo "[dockerdeploy]" > '/host/host'
        echo '127.0.0.1' >> '/host/host'
        echo [$Role] >> '/host/host'
        echo '127.0.0.1' >> '/host/host'
fi