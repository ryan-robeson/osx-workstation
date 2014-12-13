class ryan::dotfiles {
  $home = "/Users/${::boxen_user}"
  $dotfiles_dir = "${boxen::config::srcdir}/dotfiles"

  repository { $dotfiles_dir:
    source => "${::github_login}/dotfiles"
  }

  define place_dotfiles {
    $home = "/Users/${::boxen_user}"
    $dotfiles_dir = "${boxen::config::srcdir}/dotfiles"

    file { "${home}/.${title}":
      ensure => link,
      target => "${dotfiles_dir}/.${title}",
      require => Repository[$dotfiles_dir]
    }
  }

  $dotfiles = [ "zshrc", "zshenv", "zsh-mac", "vimrc", "vim", "tmux.conf", "gitconfig", "slate", "ssh/config" ]

  place_dotfiles { $dotfiles: }

  file { "${home}/.zsh-mac.sh":
    ensure => 'present'
  }

  file_line { 'add boxen src line to .zsh-mac':
    path => "${home}/.zsh-mac.sh",
    line => "[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh",
    require => File["${home}/.zsh-mac.sh"]
  }
}
