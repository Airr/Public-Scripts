#!/bin/sh
# 1_Server_LaunchDaemons
#
#
# Created by andrewws on 04/05/16.
# set -x	# DEBUG. Display commands and their arguments as they are executed
# set -v	# VERBOSE. Display shell input lines as they are read.
# set -n	# EVALUATE. Check syntax of the script but dont execute

## Variables
####################################################################################################
# Variables used by this script
rootPath="/var/AutoMagic/git_repos/rhel_6_exta"
extaID=4
extaName="Server - LaunchDaemons"
hostname=`hostname`
computerXmlPath="$1"
extaValue=`ls /etc/init.d`
## Script
####################################################################################################
xmlstarlet ed --inplace -u "/computer/extension_attributes/extension_attribute[id=${extaID}]/value" -v "${extaValue}" "$computerXmlPath"
exitCode="$?"
if [ "$exitCode" != '0' ]; then
        echo "ExitCode $exitCode while attempting to update $computerXmlPath with Exta: $extaName ID: ${extaID} with ${extaValue[@]}"
        exit 1
else
    	valueCheck=`xmlstarlet sel -t -c "/computer/extension_attributes/extension_attribute[id=${extaID}]/value" "$computerXmlPath"`
        if [ "$valueCheck" == "<value>${extaValue}</value>" ]; then
                echo "$extaName updated"
		exit 0
	else
		echo "$extaName unable to be updated"
		exit 1
	fi
fi
