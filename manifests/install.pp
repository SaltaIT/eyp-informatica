class informatica::install inherits informatica {
  file { '/etc/eyp-informatica':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
  }

  file { '/etc/eyp-informatica/global_settings.config':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/global_informatica_settings.erb"),
    require => File['/etc/eyp-informatica'],
  }

  file { '/usr/local/bin/check_informatica_repository':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => file("${module_name}/check_repository.sh"),
    require => File['/etc/eyp-informatica'],
  }

  file { '/usr/local/bin/check_nodes_alive':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => file("${module_name}/check_nodes_alive.sh"),
    require => File['/etc/eyp-informatica'],
  }
}
