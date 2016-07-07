require 'rubygems'
require 'sonos'
require 'lastfm'
require 'json'

system = Sonos::System.new
speaker = system.speakers.first

lastfm = Lastfm.new(ENV['LAST_KEY'], ENV['LAST_SECRET'])
token = lastfm.auth.get_token

SCHEDULER.every '1s' do
  @playing = speaker.now_playing
  @info = lastfm.artist.get_info(artist: @playing[:artist])
  @images = @info['image'].select {|a| a['size'] == "mega"}
  @playing['lastfm_art'] = "#{@images[0]['content']}"
  send_event('sonos', @playing)
end
