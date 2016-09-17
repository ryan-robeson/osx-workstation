class ryan::packages {
  package { 'Tunnelblick':
    provider => 'appdmg',
    source   => "http://superb-dca3.dl.sourceforge.net/project/tunnelblick/All%20files/Tunnelblick_3.3beta54.dmg",
  }

  include heroku 
	include osx::global::enable_keyboard_control_access

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
  $packages = [
    "ffmpeg --with-fdk-aac --with-opus --with-x265 --with-libvpx --with-ffplay --with-libass",
    "gnuplot --with-x11",
    "imagemagick --with-librsvg",
    "llvm --with-clang --with-clang-extra-tools --with-compiler-rt --with-libcxx --with-lld --with-rtti",
    "llvm38 --with-all-targets --with-asan --with-lld",
    "mkvtoolnix --with-gettext --with-lzo",
    "opencv3 --with-ffmpeg --c++11 --with-contrib --with-tbb --with-qt5 --with-opengl",
    "qemu --with-sdl",
    "sdl --with-x11",
    "sox --with-flac --with-lame",
    "vim --with-lua --with-luajit"
  ]

  define package_with_options {
    $t = split($title, ' ')
    $p = $t[0]
    $o = delete_at($t, 0)

    package { $p:
      ensure => present,
      install_options => [
        $o
      ]
    }
  }

  package_with_options { $packages: }

  # Simple package installs are now handled in
  # hiera/users/ryan_robeson.yaml
  #package {
  #  [
  #    'zsh'
  #  ]:
  #}

  # Installing homebrew formulas, and passing in arbitrary flags, like:
  # brew install php54 --with-fpm --without-apache
  # 
  #   package { 'php54':
  #     ensure => present,
  #     install_options => [
  #       '--with-fpm',
  #       '--without-apache'
  #     ],
  #     require => Package['zlib']
  #   }
  ### End Homebrew ###
}
