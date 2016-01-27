###
Copyright (c) 2015 Artillery Games, Inc. All rights reserved.

This source code is licensed under the MIT-style license found in the
LICENSE file in the root directory of this source tree.
###

Slack = require 'node-slack'
http = require 'http'
getenv = require 'getenv'
createHandler = require 'github-webhook-handler'

options = getenv.multi
  port: ['PORT', undefined, 'int']
  githubSecret: 'GITHUB_WEBHOOK_SECRET'
  slackUrl: 'SLACK_WEBHOOK_URL'

slack = new Slack(options.slackUrl)

handler = createHandler
  path: '/webhook'
  secret: options.githubSecret

server = http.createServer (req, res) ->
  handler req, res, (err) ->
    res.statusCode = 404
    res.end 'file not found'

server.listen options.port, ->
  {address, family, port} = server.address()
  console.log "Listening on #{ address }:#{ port } via #{ family }"

handler.on 'error', (err) -> console.error "WebHook handler error:", err

handler.on 'gollum', (event) ->
  p = event.payload
  if p.pages.length == 1
    page = p.pages[0]
    text = "_#{ page.page_name }_ was #{ page.action } by #{ p.sender.login }: #{ page.html_url }"
  else
    text = "#{ p.pages.length } pages were modified: #{ p.repository.html_url }/wiki"
  console.log text
  slack.send
    text: text
    username: "#{ p.repository.name } wiki"
    icon_emoji: ':memo:'
