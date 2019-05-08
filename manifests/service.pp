# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200  9) services:
# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200 10)   'informatica':
# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200 11)     ensure: 'running'
# ad1488ad (Jordi Prats 2018-09-06 16:29:42 +0200 12)     enable: true
class informatica::service inherits informatica {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $informatica::manage_docker_service)
  {
    if($informatica::manage_service)
    {
      service { $informatica::service_name:
        ensure => $informatica::service_ensure,
        enable => $informatica::service_enable,
      }
    }
  }
}
