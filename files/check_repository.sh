#!/bin/bash

# -bash-4.1$ LD_LIBRARY_PATH="./10.1.1/server/bin" ./10.1.1/server/bin/pmrep connect -r repo_demo -d domain_demo -s "Native" -n Administrator -x password
#
# Informatica(r) PMREP, version [10.1.1 HotFix2], build [1507.1025], LINUX 64-bit
# Copyright (c) 1993-2017 Informatica LLC. All Rights Reserved.
# See patents at https://www.informatica.com/legal/patents.html.
#
#
# Invoked at Wed May 08 12:26:07 2019
#
# Connected to repository repo_demo in infa_dom_prod as user Administrator
# connect completed successfully.
#
# Completed at Wed May 08 12:26:12 2019
# -bash-4.1$ pwd
# /opt/informatica
# -bash-4.1$

. /etc/eyp-informatica/global_settings.config

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

if [ ! -f "${INF_INSTALL_BASE}/${INF_VERSION}/server/bin/pmrep" ];
then
  echo "ERROR - pmrep not found" >&2
  exit 3
fi

. $1

sudo -u "${INF_RUN_USER}" INFA_HOME="${INF_INSTALL_BASE}/${INF_VERSION}" LD_LIBRARY_PATH="${INF_INSTALL_BASE}/${INF_VERSION}/server/bin" ${INF_INSTALL_BASE}/${INF_VERSION}/server/bin/pmrep connect -r "${INF_REPOSITORY}" -d "${INF_DOMAIN}" -s "${INF_ADMINUSER_SD}" -n "${INF_ADMINUSER}" -x "${INF_ADMINUSER_PASSWORD}" > /dev/null 2>&1

if [ $? -eq 0 ];
then
  sudo -u "${INF_RUN_USER}" INFA_HOME="${INF_INSTALL_BASE}/${INF_VERSION}" LD_LIBRARY_PATH="${INF_INSTALL_BASE}/${INF_VERSION}/server/bin" ${INF_INSTALL_BASE}/${INF_VERSION}/server/bin/pmrep connect -r "${INF_REPOSITORY}" -h 127.0.0.1 -o "${INF_ADMIN_LISTEN}" -s "${INF_ADMINUSER_SD}" -n "${INF_ADMINUSER}" -x "${INF_ADMINUSER_PASSWORD}" > /dev/null 2>&1

  if [ $? -eq 0 ];
  then
    echo "OK - connected to repo ${INF_ADMIN_LISTEN}"
  else
    echo "FAILED TO CONNECT TO ${INF_REPOSITORY} using localhost"
    exit 2
  fi

else
  echo "FAILED TO CONNECT TO ${INF_REPOSITORY} using domain"
  exit 2
fi
