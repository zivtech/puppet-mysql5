class mysql5 {
  package { 
    [
      "mysql-server",
      "mysql-client",
      "mysql-common",
    ]: 
      ensure => installed 
  }
  service { 
    [
      "mysql"
    ]:
    ensure => running,
  }
  exec { "Set MySQL server root password":
    subscribe => [ 
      Package["mysql-server"],
    ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$mysqlpassword status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $mysqlpassword",
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


