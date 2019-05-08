# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200  3) initscripts:
# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200  4)   'informatica':
# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200  5)     cmd_start: '/opt/informatica/10.1.1/tomcat/bin/infaservice.sh startup'
# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200  6)     cmd_stop: '/opt/informatica/10.1.1/tomcat/bin/infaservice.sh shutdown'
# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200  7)     tcp_listen_check: '6005'
# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200  8)     run_user: 'inf_admin_%{::ntteam_environment_lowercase}'
class informatica::config inherits informatica {

  initscript::service { $informatica::service_name:
    cmd_start        => "${informatica::install_base}/${informatica::version}/tomcat/bin/infaservice.sh startup",
    cmd_stop         => "${informatica::install_base}/${informatica::version}/tomcat/bin/infaservice.sh shutdown",
    tcp_listen_check => $informatica::admin_listen,
    run_user         => $informatica::run_user,
  }

}
