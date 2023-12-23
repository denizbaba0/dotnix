# schedule task
export def schedule [duration, message?] {
  mut nudge = "Time is up!"
  if $message != null {
    $nudge = $message
  }

  timer $duration
  notify-desktop $nudge
}

# find git dirs
export def fgit [] {
  rg --files --hidden | rg -e "\\.(ignore|git)"
}
