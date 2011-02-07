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
}


