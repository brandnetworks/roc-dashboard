require 'rubygems'
require 'sonos'
require 'lastfm'

system = Sonos::System.new
speaker = system.speakers.first
@playing = speaker.now_playing

lastfm = Lastfm.new(ENV['LAST_KEY'], ENV['LAST_SECRET'])
token = lastfm.auth.get_token

SCHEDULER.every '1s' do
  if @playing != speaker.now_playing
    @playing = speaker.now_playing
    @info = lastfm.artist.get_info(artist: @playing[:artist])
    @images = @info['image'].select {|a| a['size'] == "mega"}
    @playing['lastfm_art'] = "#{@images[0]['content']}"
    send_event('sonos', @playing)
  end
end
