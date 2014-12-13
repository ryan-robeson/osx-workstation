class ryan::master {
  $home = "/Users/${::boxen_user}"

  osx_chsh { $::luser:
    shell => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh']
  }

  file_line { 'add zsh to /etc/shells':
    path => '/etc/shells',
    line => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh']
  }

  file { ["${home}/Code", "${home}/Code/go"]:
    ensure => "directory"
  }

  include ryan::dotfiles
  include ryan::packages
  include ryan::go
  include ryan::git
  include ryan::repos

	# Install npm modules
	nodejs::module { 'express':
		node_version => 'v0.10.33'
	}

  nodejs::module { 'yo':
    node_version => 'v0.10.33'
  }

  nodejs::module { 'generator-angular':
    node_version => 'v0.10.33'
  }

}
