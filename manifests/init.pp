class informatica (
                    $manage_service        = true,
                    $manage_docker_service = true,
                    $service_ensure        = 'running',
                    $service_enable        = true,
                    $service_name          = 'informatica',
                    $install_base          = '/opt/informatica',
                    $version               = '10.1.1',
                    $admin_listen          = '6005',
                    $run_user              = 'inf_admin',
                  ) inherits informatica::params{

  class { '::informatica::install': }
  -> class { '::informatica::config': }
  ~> class { '::informatica::service': }
  -> Class['::informatica']

}
