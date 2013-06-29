class ryan::go {
  define goget {
	exec { "Get ${title}":
	environment => "GOPATH=/Users/${::boxen_user}/Code/go",
	command => "go get github.com/${title}",
	unless => "test -d /Users/${::boxen_user}/Code/go/src/github.com/${title}"
	}
  }

  goget { ["ryan-robeson/monitor_and_run"]: }
}