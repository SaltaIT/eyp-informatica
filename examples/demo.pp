class { 'informatica':
}

informatica::checkrepository { 'repo_demo':
  adminuser_sd       => 'Native',
  adminuser          => 'Administrator',
  adminuser_password => 'assword',
  domain             => 'demo_domain',
}
