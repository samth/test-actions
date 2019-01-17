workflow "New workflow" {
  on = "push"
  resolves = ["git-commit-email"]
}

action "git-commit-email" {
  uses = "./"
  secrets = ["GITHUB_TOKEN"]
}
