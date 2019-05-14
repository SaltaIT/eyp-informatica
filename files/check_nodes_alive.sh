#!/bin/bash

# <INFA_HOME>/isp/bin/infacmd.sh isp ListNodes -dn <DOMAIN_NAME> -un <USER_NAME> -pd <PASSWORD>

. /etc/eyp-informatica/global_settings.config

if [ ! -f "/etc/eyp-informatica/global_settings.config" ];
then
  echo "/etc/eyp-informatica/global_settings.config NOT FOUND"
  exit 3
fi

if [ ! -f "$1" ];
then
  echo "unable to read configuration file: $1"
  exit 3
fi

. $1

if [ -z "${EXPECTED_ALIVE_NODES}" ];
then
  echo "EXPECTED_ALIVE_NODES not defined"
  exit 3
fi

if ! [[ ${EXPECTED_ALIVE_NODES} =~ '^[0-9]+$' ]];
then
  echo "ERROR: EXPECTED_ALIVE_NODES is not a number: ${EXPECTED_ALIVE_NODES}" >&2
  exit 3
fi

if [ ! -f "${INF_INSTALL_BASE}/${INF_VERSION}/server/bin/infacmd.sh" ];
then
  echo "${INF_INSTALL_BASE}/${INF_VERSION}/server/bin/infacmd.sh NOT FOUND"
  exit 3
fi

NODES=$(sudo -u "${INF_RUN_USER}" INFA_HOME="${INF_INSTALL_BASE}/${INF_VERSION}" ${INF_INSTALL_BASE}/${INF_VERSION}/server/bin/infacmd.sh ListNodes -dn "${INF_DOMAIN}" -un "${INF_ADMINUSER}" -pd "${INF_ADMINUSER_PASSWORD}" -sdn "${INF_ADMINUSER_SD}" | grep -v "Command ran successfully")

if [ "$?" -ne 0 ];
then
  echo "ERROR getting list of nodes"
  exit 2
fi

ALIVE_NODES=0
for NODE in $NODES;
do
  sudo -u "${INF_RUN_USER}" INFA_HOME="${INF_INSTALL_BASE}/${INF_VERSION}" ${INF_INSTALL_BASE}/${INF_VERSION}/server/bin/infacmd.sh ping -dn infa_dom_prod -nn $NODE > /dev/null 2>&1

  if [ "$?" -eq 0 ];
  then
    let ALIVE_NODES=$ALIVE_NODES+1
  fi
done

if [ "${ALIVE_NODES}" -ne "${EXPECTED_ALIVE_NODES}" ];
then
  echo "ERROR: ${ALIVE_NODES} alive nodes, expected: ${EXPECTED_ALIVE_NODES}"
  exit 2
else
  echo "OK: ${ALIVE_NODES} alive nodes, expected: ${EXPECTED_ALIVE_NODES}"
  exit 0
fi
