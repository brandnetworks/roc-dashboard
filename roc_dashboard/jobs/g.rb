@today = ""

def reset_points
  @x = 0
  @y = 25
  @today = Time.new.day
  @points = []
  (0..1440).each do |i|
    @points << { x: i, y: nil }
  end
end

SCHEDULER.every '1s' do
  @today = "" if @x == 10
  reset_points if @today != Time.new.day
  @y = @y+rand(3)-1
  @points[@x] = { x: @x, y: @y }
  @x += 1
  send_event('graph', points: @points)
end
