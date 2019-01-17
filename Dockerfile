FROM alpine:latest

LABEL "com.github.actions.name"="git-commit-email"
LABEL "com.github.actions.description"="send email with the commit information"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="yellow"

RUN apk add --no-cache \
    jq \
    curl \
    git

COPY "do-email.sh" /usr/bin/do-email

CMD ["sh", "/usr/bin/do-email"]
