class mysql5 ($mysqlpassword) {
  package { 
    [
      "mysql-server",
      "mysql-client",
      "mysql-common",
    ]: 
      ensure => installed 
  }
  /*
  service {"mysql":
    ensure => running,
  }

  # TODO: This doesn't actually work.
  exec { "Set MySQL server root password":
    subscribe => [ 
      Package["mysql-server"],
    ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$mysqlpassword status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $mysqlpassword",
  }
  */

  file { 'my.cnf':
    path => "/etc/mysql/my.cnf",
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/mysql5/my.cnf",
  }

  file { "webadmin-mycnf":
    path => "/home/webadmin/.my.cnf",
    content => template("mysql5/my.cnf.erb"),
    owner => webadmin,
  }

  file { "root-mycnf":
    path => "/root/.my.cnf",
    content => template("mysql5/my.cnf.erb"),
    owner => webadmin,
  }
}

