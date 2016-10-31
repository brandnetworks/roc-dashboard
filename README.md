# Getting Started

Change your directory to `roc_dashboard` and install gems with Bundler.
Tested with Ruby 2.3.1.

    $ bundle

See http://dashing.io/ for more information about Dashing.

# API Keys

Some of the widgets require API keys to work.
Create free accounts and write down the API keys for later use.

* Twitter - https://dev.twitter.com/
    * CONSUMER_KEY 
    * CONSUMER_SECRET
    * ACCESS_TOKEN
    * ACCESS_SECRET
* Forecast.io - https://developer.forecast.io/
    * FORECAST_KEY
* Last.fm - http://www.last.fm/api
    * LAST_KEY
    * LAST_SECRET

# Starting the Dashboard

Once everthing is installed, change your directory to `roc_dashboard` and start the server. Be sure to fill in the appropriate API keys

    $ CONSUMER_KEY=apikey CONSUMER_SECRET=apikey ACCESS_TOKEN=apikey ACCESS_SECRET=apikey FORECAST_KEY=apikey LAST_KEY=apikey LAST_SECRET=apikey dashing start
    
On Windows systems, set the keys as environment variables in the system settings. Then start the server
    
    dashing start
    
Connect to the dashboard  at http://localhost:3030
