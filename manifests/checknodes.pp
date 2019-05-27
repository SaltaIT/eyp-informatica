define informatica::checknodes(
                                $domain               = $name,
                                $adminuser_sd         = 'Native',
                                $adminuser            = 'Administrator',
                                $adminuser_password   = 'password',
                                $expected_alive_nodes = '2',
                              ) {

  include ::informatica

  file { "/etc/eyp-informatica/checknodesalive_${domain}.config":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/check_nodes_alive_config.erb"),
    require => Class['::informatica'],
  }
}
