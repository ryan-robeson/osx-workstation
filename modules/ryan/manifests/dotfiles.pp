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
}
