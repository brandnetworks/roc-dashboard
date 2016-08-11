require 'net/http'
require 'json'
require 'time'
require 'open-uri'
require 'cgi'

@today = ""

JIRA_OPENISSUES_CONFIG = {
  jira_url: "https://jira.brandnetworksinc.com",
  username:  "jira-reader",
  password: ENV['JIRA_PASS'],
  issuecount_mapping: {
    'filterX' => "filter=12504"
  }
}

def reset_points
  @today = Time.new.day
  time = Time.new.to_s
  @x = (time[11,2].to_i * 60 + time[14,2].to_i)
  @points = []
  (0..1440).each do |i|
    @points << { x: i, y: -1 }
  end
end

def getNumberOfIssues(url, username, password, jqlString)
  jql = CGI.escape(jqlString)
  uri = URI.parse("#{url}/rest/api/2/search?jql=#{jql}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = uri.scheme == 'https'
  request = Net::HTTP::Get.new(uri.request_uri)
  if !username.nil? && !username.empty?
    request.basic_auth(username, password)
  end
  JSON.parse(http.request(request).body)["total"]
end

JIRA_OPENISSUES_CONFIG[:issuecount_mapping].each do |mappingName, filter|
  SCHEDULER.every '60s', :first_in => 0 do
    total = getNumberOfIssues(JIRA_OPENISSUES_CONFIG[:jira_url], JIRA_OPENISSUES_CONFIG[:username], JIRA_OPENISSUES_CONFIG[:password], filter)
    reset_points if @today != Time.new.day
    @points[@x] = { x: @x, y: total}
    send_event('data1', { points: @points, current: @points[@x][:y] })
    @x += 1
  end
end
