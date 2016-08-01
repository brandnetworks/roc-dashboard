require 'rubygems'
require 'sonos'
require 'lastfm'

sonos_system = Sonos::System.new
speaker = sonos_system.speakers.first
@playing = {:title => ""}

lastfm = Lastfm.new(ENV['LAST_KEY'], ENV['LAST_SECRET'])
token = lastfm.auth.get_token

SCHEDULER.every '1s' do
  @current = speaker.now_playing
  if @current != {} && @playing[:title] != @current[:title]
    @playing = @current
    if @playing[:album_art] != ""
      @playing[:album_art] = "http://#{@playing[:album_art].rpartition('http://').last}"
    end
    @info = lastfm.artist.get_info(artist: @playing[:artist])
    @images = @info['image'].select {|a| a['size'] == "mega"}
    @playing['lastfm_art'] = "#{@images[0]['content']}"
    @playing[:music] = true
  elsif @playing[:title] == @current[:title]
    #continue playing
  else
    @playing[:title] = "No Music"
    @playing[:artist] = ""
    @playing[:album] = ""
    @playing[:music] = false
  end
  send_event('sonos', @playing)
end
