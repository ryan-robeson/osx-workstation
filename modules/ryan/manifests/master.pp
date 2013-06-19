class ryan::master {
  osx_chsh { $::luser:
    shell => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh']
  }

  file_line { 'add zsh to /etc/shells':
    path => '/etc/shells',
    line => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh']
  }

  $home = "/Users/${::boxen_user}"
  $dotfiles_dir = "${boxen::config::srcdir}/dotfiles"

  repository { $dotfiles_dir:
    source => "${::github_login}/dotfiles"
  }

  file { ["${home}/Code", "${home}/Code/go"]:
    ensure => "directory"
  }

  file { "${home}/.zshrc":
    ensure => link,
    target => "${dotfiles_dir}/.zshrc",
    require => Repository[$dotfiles_dir]
  }

  file_line { 'add boxen src line to .zshrc':
    path => "${home}/.zshrc",
    line => "[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh",
    require => File["${home}/.zshrc"]
  }

  file { "${home}/.vimrc":
    ensure => link,
    target => "${dotfiles_dir}/.vimrc",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.vim":
    ensure => link,
    target => "${dotfiles_dir}/.vim",
    require => Repository[$dotfiles_dir]
  }
 
  file { "${home}/.tmux.conf":
    ensure => link,
    target => "${dotfiles_dir}/.tmux.conf",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.gitconfig":
    ensure => link,
    target => "${dotfiles_dir}/.gitconfig",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.slate":
    ensure => link,
    target => "${dotfiles_dir}/.slate",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.ssh/config":
    ensure => link,
    target => "${dotfiles_dir}/.ssh/config",
    require => Repository[$dotfiles_dir]
  }

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

  include dropbox
  include virtualbox
  include vagrant
  include heroku
  include pow
  include vlc
  include slate
  include skype
  include transmission
  include handbrake
  include xquartz
	include osx::global::enable_keyboard_control_access

  $code_repos = [ 'www.smokymountainaeroplanes.com', 'Video-Fixer' ]

  define code_repositories {	
		$home = "/Users/${::boxen_user}"
    repository { "${home}/Code/${title}":
			source => "${::github_login}/${title}",
			require => File["${home}/Code"]
		}
  }

  code_repositories { $code_repos: }

	define goget {
		exec { "Get ${title}":
			environment => "GOPATH=/Users/${::boxen_user}/Code/go",
			command => "go get github.com/${title}",
			unless => "test -d /Users/${::boxen_user}/Code/go/src/github.com/${title}"
		}
	}

	goget { ["ryan-robeson/monitor_and_run"]: }

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

	# Install npm modules
	nodejs::module { 'express':
		node_version => 'v0.10.5'
	}

}
