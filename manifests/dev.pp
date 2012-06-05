# Development MySQL settings
class mysql5::dev inherits mysql5 {
  File['my.cnf'] {
    source => "puppet:///modules/mysql5/dev.my.cnf",
  }

}

