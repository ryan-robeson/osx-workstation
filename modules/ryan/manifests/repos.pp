class ryan::repos {
  $code_repos = [ 'www.smokymountainaeroplanes.com', 'Video-Fixer' ]

  define code_repositories {  
    $home = "/Users/${::boxen_user}"
    repository { "${home}/Code/${title}":
      source => "${::github_login}/${title}",
      require => File["${home}/Code"]
    }
  }

  code_repositories { $code_repos: }
}