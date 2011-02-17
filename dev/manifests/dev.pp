class dev {
  package { 
    [
      "build-essential",
      "ntp",
    ]: 
      ensure => installed 
  }
  cron { logrotate:
    command => "ntpdate ntp.ubuntu.com",
      user => root,
      minute => '*/10'
  }
}

