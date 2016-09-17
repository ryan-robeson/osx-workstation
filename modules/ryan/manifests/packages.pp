class ryan::packages {
  package { 'Tunnelblick':
    provider => 'appdmg',
    source   => "http://superb-dca3.dl.sourceforge.net/project/tunnelblick/All%20files/Tunnelblick_3.3beta54.dmg",
  }

  package { 'GIMP':
    provider => 'appdmg',
    source   => "ftp://ftp.gimp.org/pub/gimp/v2.8/osx/gimp-2.8.4-nopython-dmg-1.dmg"
  }

  package { 'XBMC':
    provider => 'appdmg',
    source   => "http://mirrors.xbmc.org/releases/osx/xbmc-12.2-x86_64.dmg"
  }

  package { 'Inkscape':
    provider => 'appdmg',
    source   => "http://iweb.dl.sourceforge.net/project/inkscape/inkscape/0.48.2/Inkscape-0.48.2-1-SNOWLEOPARD.dmg"
  }

	package { 'CoRD':
		provider => 'compressed_app',
		source => 'http://superb-dca2.dl.sourceforge.net/project/cord/cord/0.5.7/CoRD_0.5.7.zip'
	}

  package { 'Keka':
    provider => 'appdmg',
    source   => 'http://www.kekaosx.com/release/Keka-1.0.3-intel.dmg'
  }

  package { 'Skim':
    provider => 'appdmg',
    source => 'http://softlayer-dal.dl.sourceforge.net/project/skim-app/Skim/Skim-1.4.4/Skim-1.4.4.dmg'
  }

  include dropbox
  include firefox
  include handbrake
  include heroku 
	include osx::global::enable_keyboard_control_access
  include skype
  include slate 
  include transmission
  include vagrant 
  include virtualbox 
  include vlc 
  include xquartz

  ### Dropbox ###
  $dropbox_repos = [ "cycle_timer", "hbc", "hbc_events", "mds/truck_tracker", "www.docksidelogistics.com" ]

  define repo_from_dropbox {
    $home = "/Users/${::boxen_user}"
    $dropbox_code = "${home}/Dropbox/code"

    repository { "${home}/Code/${title}":
      source => "${dropbox_code}/${title}.git",
      require => File["${home}/Code"]
    }
  }

  repo_from_dropbox { $dropbox_repos: }
  ### Dropbox ###

  ### Homebrew ###
  package {
    [
    'ack',
    'aircrack-ng',
    'ansible',
    'archivemount',
    'aria2',
    'autoconf',
    'automake',
    'axel',
    'bwctl',
    'bwm-ng',
    'cabextract',
    'cairo',
    'cctools',
    'class-dump',
    'clojure',
    'clozure-cl',
    'cmake',
    'coreutils',
    'cowsay',
    'csv-fix',
    'ctags',
    'curl',
    'dcraw',
    'ddrescue',
    'dnsmasq',
    'docker',
    'dos2unix',
    'exiftool',
    'faac',
    'fdk-aac',
    'ffmpeg',
    'figlet',
    'findutils',
    'flac',
    'fontconfig',
    'freerdp',
    'freetype',
    'fribidi',
    'fuse4x',
    'fuse4x-kext',
    'gcc',
    'gd',
    'gdb',
    'geoip',
    'gettext',
    'gifsicle',
    'git',
    'gnu-sed',
    'gnu-tar',
    'gnupg2',
    'gnuplot',
    'gnutls',
    'go',
    'gpg-agent',
    'graphviz',
    'gtk+',
    'harfbuzz',
    'htop-osx',
    'hub',
    'imagemagick',
    'ipcalc',
    'iperf',
    'iperf3',
    'libdvdcss',
    'libiconv',
    'libtool',
    'lrzip',
    'lua',
    'luajit',
    'lz4',
    'lzo',
    'lzop',
    'mednafen',
    'mercurial',
    'mitmproxy',
    'mkvtoolnix',
    'mono',
    'mozjpeg',
    'mplayer',
    'namebench',
    'nasm',
    'ncdu',
    'nettle',
    'nmap',
    'numpy',
    'opencv3',
    'openexr',
    'openssl',
    'p7zip',
    'pandoc',
    'pango',
    'pixz',
    'pkg-config',
    'pngcrush',
    'pngquant',
    'poppler',
    'proxychains-ng',
    'pv',
    'pwgen',
    'python3',
    'qemu',
    'qt5',
    'readline',
    'reattach-to-user-namespace',
    'reaver',
    'rsync',
    'rust',
    's3cmd',
    'socat',
    'sox',
    'sqlite',
    'squashfs',
    'ssh-copy-id',
    'sshfs',
    'tesseract',
    'tmux',
    'tree',
    'tsocks',
    'unrar',
    'vim',
    'wakeonlan',
    'watch',
    'wget',
    'xz',
    'yasm',
    'youtube-dl',
    'zpaq',
    'zsh'
    ]:
  }
  ### End Homebrew ###
}
