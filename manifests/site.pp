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
  require  => Class['homebrew'],
  install_options => ['--build-from-source'],
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
      'ansible',
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
      'libvirt',
      'leiningen',
      'nmap',
      'p7zip',
      'pwgen',
      's3cmd',
      'ssh-copy-id',
      'sshfs',
      'tesseract',
      'tmux',
      'tree',
      'gnu-tar',
      'gpg2',
      'qemu',
      'unrar',
      'watch',
      'youtube-dl',
      'zsh'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }

  include ryan::master

}
