define informatica::checkrepository (
                                      $repo_name          = $name,
                                      $adminuser_sd       = 'Native',
                                      $adminuser          = 'Administrator',
                                      $adminuser_password = 'password',
                                      $domain             = 'inf_domain',
                                    ) {

  include ::informatica

  file { "/etc/eyp-informatica/repo_${repo_name}.config":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/check_repository_config.erb"),
    require => Class['::informatica'],
  }
}
