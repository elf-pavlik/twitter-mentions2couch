Twit = require 'twit'
cradle = require 'cradle'

db = new(cradle.Connection)(process.env.COUCH_IP, process.env.COUCH_PORT, {auth: {username: process.env.COUCH_USERNAME, password: process.env.COUCH_PASSWORD}}).database('ouisharefest-mentions')

T = new Twit
  consumer_key: process.env.CONSUMER_KEY
  consumer_secret: process.env.CONSUMER_SECRET
  access_token: process.env.ACCESS_TOKEN
  access_token_secret: process.env.ACCESS_TOKEN_SECRET

saveTweet = (tweet) ->
  db.save tweet.id_str, tweet, (err, res) ->
    console.log err if err

stream = T.stream 'statuses/filter', { track: '@OuiShareFest' }

stream.on 'tweet', (tweet) ->
  saveTweet tweet
