class mysql5-dev ($mysqlpassword) inherits mysql5 ($mysqlpassword) {

  File['my.cnf'] {
    source => "puppet:///modules/mysql5-dev/my.cnf",
  }

}

