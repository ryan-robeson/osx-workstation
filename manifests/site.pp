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
  ruby::version { '1.9.3': }
  ruby::version { '2.0.0': }
  ruby::version { '2.1.0': }
  ruby::version { '2.1.1': }
  ruby::version { '2.1.2': }

  # common, useful packages
  package {
    [
      'ack',
      'ansible',
      'boot2docker',
      'clojure',
      'clozure-cl',
      'docker',
      'dvdauthor',
      'findutils',
      'dos2unix',
      'exiftool',
      'ffmpeg',
      'go',
      'graphicsmagick',
      'graphviz',
      'hg',
      'htop-osx',
      'libdvdcss',
      'libvirt',
      'leiningen',
      'mitmproxy',
      'ncdu',
      'nmap',
      'p7zip',
      'pwgen',
      's3cmd',
      'squashfs',
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
