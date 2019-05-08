class informatica::service inherits informatica {

  #
  validate_bool($informatica::manage_docker_service)
  validate_bool($informatica::manage_service)
  validate_bool($informatica::service_enable)

  validate_re($informatica::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${informatica::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $informatica::manage_docker_service)
  {
    if($informatica::manage_service)
    {
      service { $informatica::params::service_name:
        ensure => $informatica::service_ensure,
        enable => $informatica::service_enable,
      }
    }
  }
}
