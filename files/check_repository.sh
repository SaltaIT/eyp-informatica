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

source /etc/eyp-informatica/global_settings.config

if [ -z "$1" ];
then
  echo "check repository using pmrep"
  echo "usage:"
  echo "$0 <config file>"
  exit 3
fi

if [ ! -f "$1" ];
then
  echo "unable to read configuration file: $1"
  exit 3
fi

source $1

sudo -u "${INF_RUN_USER}" INFA_HOME="${INF_INSTALL_BASE}/${INF_VERSION}" LD_LIBRARY_PATH="${INF_INSTALL_BASE}/${INF_VERSION}/server/bin" ${INF_INSTALL_BASE}/${INF_VERSION}/server/bin/pmrep connect -r "${INF_REPOSITORY}" -d "${INF_DOMAIN}" -s "${INF_ADMINUSER_SD}" -n "${INF_ADMINUSER}" -x "${INF_ADMINUSER_PASSWORD}"

if [ $? -eq 0 ];
then
  echo "OK - repo ${INF_REPOSITORY}"
  exit 0
else
  echo "FAILED TO CONNECT TO ${INF_REPOSITORY}"
  exit 2
fi
