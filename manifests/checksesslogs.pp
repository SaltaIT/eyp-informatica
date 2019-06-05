define informatica::checksesslogs (
                                    $sess_logs_dir,
                                    $sess_logs_name   = $name,
                                    $bh_start         = '05',
                                    $bh_end           = '16',
                                    $bh_max_hours     = '1',
                                    $global_max_hours = '24',
                                  ) {

  include ::informatica

  file { "/etc/eyp-informatica/checksesslogs_${sess_logs_name}.config":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/check_sess_logs.erb"),
    require => Class['::informatica'],
  }
}
