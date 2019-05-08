class informatica::install inherits informatica {

  if($informatica::manage_package)
  {
    package { $informatica::params::package_name:
      ensure => $informatica::package_ensure,
    }
  }

}
