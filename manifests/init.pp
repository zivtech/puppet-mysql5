class mysql5($mysqlpassword, $webadminuser = "root", $webadmingroup = "root") {
  package { "mysql":
      name => [
        "mysql-server",
        "mysql-client",
        "mysql-common",
      ],
      ensure => installed,
  }

  # TODO: This only does the initial set, it won't reset it.
  exec { "Set MySQL server root password":
    refreshonly => true,
    unless => "mysqladmin -uroot -p$mysqlpassword status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $mysqlpassword",
    require => Package['mysql']
  }

  # exec { "set-mysql-password":
  #   unless => "mysqladmin -uroot -p$mysqlpassword status",
  #   path => ["/bin", "/usr/bin"],
  #   command => "mysqladmin -uroot password $mysqlpassword",
  #   require => Package["mysql"],
  # }

  file { 'my.cnf':
    path => "/etc/mysql/my.cnf",
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/mysql5/my.cnf",
    require => Package['mysql']
  }

  file { "root-mycnf":
    path => "/root/.my.cnf",
    content => template("mysql5/my.cnf.erb"),
    owner => root,
    require => Package['mysql']
  }

  file { "admin-mycnf":
    path => "/home/$webadminuser/.my.cnf",
    content => template("mysql5/my.cnf.erb"),
    owner => $webadminuser,
    group => $webadmingroup,
    require => Package['mysql']
  }

}

