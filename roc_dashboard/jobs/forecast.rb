require 'json'
require 'forecast_io'

ForecastIO.api_key = 'fa2752a8131aa722e5d3f45570c0c11a'

SCHEDULER.every '120s' do
  @forecast = ForecastIO.forecast(43.1598610, -77.6151030)
  @hourly = @forecast['hourly']
  @minutely = @forecast['minutely']
  @data = @hourly['data']
  @current_hour_data = @data[0]
  send_event('temperature', { current: @current_hour_data["temperature"], increasing: increasing_temp, icon: @minutely["icon"]})
end

def increasing_temp
  current_temp = @current_hour_data["temperature"]
  sum = 0
  included = 0
  for i in 1..4
    next_hour_data = @data[i]
    if(next_hour_data["temperature"] != nil)
      sum += next_hour_data["temperature"]
      included += 1
    end
  end
  average_temp = sum/included
  average_temp > current_temp
end
