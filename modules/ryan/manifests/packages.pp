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

  package { 'Skim':
    provider => 'appdmg',
    source => 'http://softlayer-dal.dl.sourceforge.net/project/skim-app/Skim/Skim-1.4.4/Skim-1.4.4.dmg'
  }

  package { 'Pandoc':
    provider => 'pkgdmg',
    source => 'https://pandoc.googlecode.com/files/pandoc-1.11.1.dmg'
  }

  include cyberduck
  include dropbox
  include firefox
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
	include sublime_text_2
	include osx::global::enable_keyboard_control_access

  ### Sublime Text 2 ###
	sublime_text_2::package { 'Emmet':
		  source => 'sergeche/emmet-sublime'
	}

	sublime_text_2::package { 'SublimeREPL':
		source => 'wuub/SublimeREPL'
	}

  sublime_text_2::package { 'GitGutter':
    source => 'jisaacks/GitGutter'
  }

  sublime_text_2::package { 'Sublime_Terminal':
    source => 'wbond/sublime_terminal'
  }

  sublime_text_2::package { 'Sublime_LiveReload':
    source => 'dz0ny/LiveReload-sublimetext2'
  }

  sublime_text_2::package { 'Markdown Preview':
    source => 'revolunet/sublimetext-markdown-preview'
  }

  sublime_text_2::package { 'LatexTools':
    source => 'SublimeText/LaTeXTools'
  }

  sublime_text_2::package { 'CheckBounce':
    source => 'phyllisstein/CheckBounce'
  }
  ### Sublime Text 2 ###

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
}
