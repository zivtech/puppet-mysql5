class mysql5::dev($mysqlpassword) inherits mysql5 {
  class { 'mysql5':
    mysqlpassword => $mysqlpassword,
  }
  File['my.cnf'] {
    source => "puppet:///modules/mysql5/dev.my.cnf",
  }

}

