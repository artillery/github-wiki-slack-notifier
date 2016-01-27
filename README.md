# github-wiki-slack-notifier

Heroku app that sends updates for a (probably private) GitHub wiki to a Slack channel.

## Getting Started (Example)

Clone this repo, create the app, and note the URL

```
$ heroku create
heroku-cli: Installing core plugins... done
Creating honking-mallard-37812... done, stack is cedar-14
https://honking-mallard-37812.herokuapp.com/ | https://git.heroku.com/honking-mallard-37812.git
Git remote heroku added

$ git push heroku master
Counting objects: 7, done.
...
remote: Verifying deploy... done.
To https://git.heroku.com/honking-mallard-37812.git
 * [new branch]      master -> master
```

Create a random string to use as a GitHub webhook secret:

  $ head /dev/random | md5
  6494f0d6e7719dfd54d4160fd22feffd

Go to `https://github.com/<your>/<repo>/settings/hooks/new` and create a new webhook

  - Payload URL: `https://honking-mallard-37812.herokuapp.com/webhook` (note trailing `/webhook`)
  - Content type: application/json
  - Secret: `6494f0d6e7719dfd54d4160fd22feffd` (from above)
  - Which events? "Let me select individual events" and check "Gollum"
  - Active: Checked

Tell the app about that secret:

```
$ heroku config:set GITHUB_WEBHOOK_SECRET=6494f0d6e7719dfd54d4160fd22feffd
```

Then go to `https://<you>.slack.com/services` and create a new Incoming WebHook for the channel you want. Tell the app about that URL:

```
$ heroku config:set SLACK_WEBHOOK_URL=https://hooks.slack.com/services/XXXXXXXXX/YYYYYYYYY/zzzzzzzzzzzzzzzzzzzzzzzz
```



