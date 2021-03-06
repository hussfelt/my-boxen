require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
  #install_options => ['--build-from-source']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  include nodejs::v0_6
  include nodejs::v0_8
  include nodejs::v0_10

  # default ruby versions
  ruby::version { '1.9.3': }
  ruby::version { '2.0.0': }
  ruby::version { '2.1.0': }
  ruby::version { '2.1.1': }
  ruby::version { '2.1.2': }

  # we use python for fabric
  include xquartz
  include python

  # php requirements
  include autoconf
  include libpng
  include libtool
  include pkgconfig
  include pcre
  include wget

  include php::5_4
  include php::5_5
  include php::fpm::5_4_29
  include php::fpm::5_5_13

  # replace system php with this one
  # comment if don't need it
  class { 'php::global':
        version => '5.5.13'
  }

  # install the php-intl extention
  php::extension::intl { "intl for 5.4.29":
    php     => '5.4.29',
    version => '3.0.0'
  }

  # install the php-xdebug extention
  php::extension::xdebug { "xdebug for 5.4.29":
    php     => '5.4.29',
    version => '2.2.5'
  }

  # install the php-xdebug extention
  php::extension::mcrypt { "mcrypt for 5.4.29":
    php     => '5.4.29'
  }

  # Fix OSX recovery message
  osx::recovery_message { 'If this Mac is found, please call +46708321222 or email henrik@hussfelt.net.': }

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
