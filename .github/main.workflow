workflow "Publish to SNS topic on push" {
  on = "push"
  resolves = ["Publish"]
}

action "EmailMessage" {
  uses = "./.github/actions/generate-email-message"
}

action "Publish" {
  needs = ["EmailMessage"]
  uses = "actions/aws/cli@master"
  args = "ses send-email --from 'commit-notifications@racket-lang.org' --to 'samth@indiana.edu' --subject file:///github/home/EmailMessage.Subject.txt --text file:///github/home/EmailMessage.Body.txt"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}
