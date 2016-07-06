require 'rubygems'
require 'sonos'

system = Sonos::System.new
speaker = system.speakers.first

SCHEDULER.every '1s' do
  @a = []
  @playing = speaker.now_playing

  send_event('sonos', @playing)
end
