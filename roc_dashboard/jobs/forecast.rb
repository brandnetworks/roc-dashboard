require 'json'
require 'forecast_io'

ForecastIO.api_key = ENV['FORECAST_KEY']

def increasing_temp
  current_temp = @currently['temperature']
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

SCHEDULER.every '120s' do
  @forecast = ForecastIO.forecast(43.159861,-77.615103)
  @currently = @forecast['currently']
  @data = @forecast['hourly']['data']
  send_event('temperature', { current: @currently["temperature"].round, increasing: increasing_temp, icon: @currently["icon"]})
end
