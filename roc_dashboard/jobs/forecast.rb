require 'json'
require 'forecast_io'

def increasing_temp
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
  average_temp > @currently['temperature']
end

def send_temperature
  forecast = ForecastIO.forecast(43.159861,-77.615103)
  @currently = forecast['currently']
  @data = forecast['hourly']['data']
  summary = forecast['minutely']['summary']
  send_event('temperature', { current: @currently["temperature"].round, increasing: increasing_temp, icon: @currently["icon"], summary: summary})
end

ForecastIO.api_key = ENV['FORECAST_KEY']
send_temperature

SCHEDULER.every '120s' do
  send_temperature
end
