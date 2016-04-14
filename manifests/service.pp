# class mailcatcher::service
#
class mailcatcher::service {
  if ( $mailcatcher::params::provider == 'systemd' ) {
    exec { 'mailcatcher-systemctl-daemon-reload':
      command     => '/bin/systemctl daemon-reload',
      refreshonly => true,
      before      => Service['mailcatcher']
    }
  }

  service {'mailcatcher':
    ensure     => 'running',
    enable     => $mailcatcher::service_enable,
    provider   => $mailcatcher::params::provider,
    hasstatus  => true,
    hasrestart => true,
    require    => Class['mailcatcher::config'],
  }
}
