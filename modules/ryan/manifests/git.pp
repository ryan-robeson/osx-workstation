class ryan::git {
  $git_ignore_lines = [ '*.7z', '*.dmg', '*.gz', '*.iso', '*.jar', '*.rar', '*.tar', '*.zip', '*.sublime-workspace']

  define git_ignore_lines {
    file_line { "add ${title} to gitignore":
      path => "${git::config::configdir}/gitignore",
      line => "${title}",
      require => File["${git::config::configdir}/gitignore"]
    }
  }

  git_ignore_lines { $git_ignore_lines: }
}