workflow "Publish to SNS topic on push" {
  on = "push"
  resolves = ["Publish"]
}

action "EmailMessage" {
  uses = "./.github/actions/generate-email-message"
}

action "Topic" {
  uses = "actions/aws/cli@master"
  needs = ["EmailMessage"]
  args = "sns create-topic --name my-topic"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}

action "Publish" {
  needs = ["Topic", "EmailMessage"]
  uses = "actions/aws/cli@master"
  args = "sns publish --topic-arn `jq .TopicArn /github/home/Topic.json --raw-output`--subject `cat file:///github/home/EmailMessage.Subject.txt` --message file:///github/home/EmailMessage.Body.txt"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}
