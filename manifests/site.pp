require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $luser,

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
    "HOME=/Users/${::luser}"
  ]
}

File {
  group => 'staff',
  owner => $luser
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => Class['git'],
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
  include git
  include hub

  # node versions
  include nodejs::v0_10

  # default ruby versions
  include ruby::1_9_3
  include ruby::2_0_0

  # common, useful packages
  package {
    [
      'ack',
      'clojure',
      'findutils',
      'dos2unix',
      'exiftool',
      'ffmpeg',
      'go',
      'graphicsmagick',
      'graphviz',
      'htop-osx',
      'libdvdcss',
      'leiningen',
      'nmap',
      'p7zip',
      'pwgen',
      's3cmd',
      'ssh-copy-id',
      'sshfs',
      'tmux',
      'tree',
      'gnu-tar',
      'gpg2',
      'zsh'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }

  include ryan::master

}
