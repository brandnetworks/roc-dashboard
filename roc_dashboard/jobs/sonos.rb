require 'rubygems'
require 'sonos'
require 'lastfm'

sonos_system = Sonos::System.new
speaker = sonos_system.speakers.first
@playing = {:title => ""}

lastfm = Lastfm.new(ENV['LAST_KEY'], ENV['LAST_SECRET'])
token = lastfm.auth.get_token

SCHEDULER.every '1s' do
  begin
    @current = speaker.now_playing
  rescue StandardError => e
    # cannot connect to Sonos
  end
  # ads from Pandora do not have an artist
  if @current && @current[:artist] != "" && @playing[:title] != @current[:title]
    @playing = @current
    @playing[:music] = true
    @info = lastfm.artist.get_info(artist: @playing[:artist])
    if @info != nil
      @images = @info['image'].select {|a| a['size'] == "mega"}
      @playing['lastfm_art'] = "#{@images[0]['content']}"
    end
  elsif @current && @playing[:title] == @current[:title]
    #continue playing
  else
    @playing[:title] = "No Music"
    @playing[:artist] = ""
    @playing[:album] = ""
    @playing[:music] = false
  end
  send_event('sonos', @playing)
end
