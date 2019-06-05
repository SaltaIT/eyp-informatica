#!/bin/bash

. /etc/eyp-informatica/global_settings.config

# [root@ar-tst1-inf01 SessLogs]# pwd
# /shared_fs/ihub/infa_shared/lcih/ARL/SessLogs

if [ -z "$1" ];
then
  echo "check repository using pmrep"
  echo "usage:"
  echo "$0 <config file>"
  exit 3
fi

if [ ! -f "$1" ];
then
  echo "unable to read configuration file: $1" >&2
  exit 3
fi

. $1

if ! [[ "${BH_START}" =~ ^[0-9]+$ ]];
then
  echo "BH_START not an integer -->${BH_START}<--"  >&2
  exit 3
fi

if ! [[ "${BH_END}" =~ ^[0-9]+$ ]];
then
  echo "BH_END not an integer -->${BH_END}<--"  >&2
  exit 3
fi

if ! [[ "${BH_MAX_HOURS}" =~ ^[0-9]+$ ]];
then
  echo "BH_MAX_HOURS not an integer -->${BH_MAX_HOURS}<--"  >&2
  exit 3
fi

if ! [[ "${GLOBAL_MAX_HOURS}" =~ ^[0-9]+$ ]];
then
  echo "GLOBAL_MAX_HOURS not an integer -->${GLOBAL_MAX_HOURS}<--"  >&2
  exit 3
fi

LAST_LOG_TS=$(ls -tl --time-style='+%s' "${SESS_LOGS_DIR}" | head -n2 | tail -n1 | awk '{ print $6 }')
CURRENT_TS=$(date +%s)
CURRENT_HOUR=$(date +%H)

if [ "$((${CURRENT_TS}-LAST_LOG_TS))" -gt "$((${GLOBAL_MAX_HOURS}*60*60))" ];
then
  echo "No logs have been generated in the last ${GLOBAL_MAX_HOURS} hours"
  exit 2
fi

# within BH ensure at least a file in generated every hour
if [ "${CURRENT_HOUR}" -gt "${BH_START}" ] && [ "${CURRENT_HOUR}" -le "${BH_END}" ];
then
  if [ "$((${CURRENT_TS}-LAST_LOG_TS))" -gt "$((${BH_MAX_HOURS}*60*60))" ];
  then
    echo "No logs have been generated within the last ${BH_MAX_HOURS} hour(s)"
    exit 2
  fi
fi

echo "sess logs diff: $((${CURRENT_TS}-${LAST_LOG_TS})) - OK"
exit 0
