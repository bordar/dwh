#!/bin/bash
KITCHEN=/usr/local/pentaho/pdi/kitchen.sh
ROOT_DIR=/opt/kaltura/dwh
WHEN=$(date +%Y%m%d)

while getopts "k:p:" o
do	case "$o" in
    k)	KITCHEN="$OPTARG";;
    p)	ROOT_DIR="$OPTARG";;
	[?])	echo >&2 "Usage: $0 [-k  pdi-path] [-p dwh-path]"
		exit 1;;
	esac
done

LOGFILE=$ROOT_DIR/logs/etl_perform_retention_policy-${WHEN}.log

export KETTLE_HOME=$ROOT_DIR
sh $KITCHEN /file $ROOT_DIR/etlsource/perform_retention_policy.kjb >> $LOGFILE 2>&1
