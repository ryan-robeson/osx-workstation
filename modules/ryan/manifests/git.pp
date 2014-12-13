class ryan::git {
  # Overwrite the default gitignore provided by puppet-git
  File <| title == "${gitconfigdir}/gitignore" |> {
    source => undef,
    content => file('ryan/gitignore'),
    require => File["${gitconfigdir}"]
  }
}
