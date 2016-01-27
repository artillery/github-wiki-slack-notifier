# github-wiki-slack-notifier

Heroku app that sends updates for a (probably private) GitHub wiki to a Slack channel.

## Getting Started

1. Create a random string to use as a GitHub webhook secret:

  $ head /dev/random | md5
  6494f0d6e7719dfd54d4160fd22feffd
