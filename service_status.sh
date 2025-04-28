#!/bin/bash
##
# BASH script that checks the following:
#
#   - Services status on remote servers
#
##

################################################# Varriable definitions & Please Don't edit following lines #########################################################

CURRENT_TIME=$(date +'%d/%m/%Y %H:%M:%S')
HOST_NAME=`hostname -f`
SERVICE_LIST=/tmp/script/servicelist.txt
REMOTE_SERVER_IP=/tmp/script/remoteservers.txt

#####################################################################################################################################################################

####################################################### VERIFY ALL FILES EXISTS OR NOT ##############################################################################

	function verify_files() {
	
		[ -f "$SERVICE_LIST" ] && [ -f "$REMOTE_SERVER_IP"  ]
		
	}
	

	if verify_files "SERVICE_LIST" "REMOTE_SERVER_IP"
	        then
                echo
		else
			echo "Please check both \"serverlist.txt and remoteservers.txt\" files are exists under $(dirname -- "$SERVICE_LIST") or Move the files and try again"
        	
			exit
    fi
#####################################################################################################################################################################

#################################################### LOGIN INTO NODE AND VERIFY SERVICES STATUS #####################################################################

function host_service_check() {
	for HOST in $(cat $REMOTE_SERVER_IP); 
		do
			for SERVICE in $(cat $SERVICE_LIST);
			do
				VALUE=$(ssh root@$HOST echo $(ps -ef | grep -v grep | grep $SERVICE  | wc -l))
				if [ $VALUE -ge 2 ];
				then
					echo "Time:$CURRENT_TIME $SERVICE is running"  >> "$HOST"".LOG.TXT"
				else
					echo "Time:$CURRENT_TIME $SERVICE is not running"  >> "$HOST"".LOG.TXT"
				fi
			done
		done
	}
	
host_service_check