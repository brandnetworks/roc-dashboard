require 'rubygems'
require 'sonos'
require 'lastfm'

sonos_system = Sonos::System.new
speaker = sonos_system.speakers.first
@playing = {:title => ""}

lastfm = Lastfm.new(ENV['LAST_KEY'], ENV['LAST_SECRET'])

SCHEDULER.every '1s' do
  begin
    current = speaker.now_playing
  rescue StandardError => e
    # cannot connect to Sonos
  end
  # detect if music is playing (ads from Pandora do not have an artist)
  if current && current[:artist] != "" && @playing[:title] != current[:title]
    @playing = current
    @playing[:music] = true
    # remove sections within parentheses
    artist = @playing[:artist]
    while artist.gsub!(/\([^()]*\)/,""); end
    # get artist image from lastfm
    @lastfm_info = lastfm.artist.get_info(artist: artist.strip)
    if @lastfm_info != nil
      @images = @lastfm_info['image'].select {|a| a['size'] == "mega"}
      @playing['lastfm_art'] = "#{@images[0]['content']}"
    end
  elsif current && @playing[:title] == current[:title]
    # continue playing
  else
    @playing[:title] = "No Music"
    @playing[:artist] = ""
    @playing[:album] = ""
    @playing[:music] = false
  end
  send_event('sonos', @playing)
end
