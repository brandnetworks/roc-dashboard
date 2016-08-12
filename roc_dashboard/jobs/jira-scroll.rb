require 'net/http'
require 'json'
require 'time'
require 'open-uri'
require 'cgi'

@info = {}

JIRA_OPENISSUES_CONFIG = {
  jira_url: "https://jira.brandnetworksinc.com",
  username:  "jira-reader",
  password: ENV['JIRA_PASS'],
  issuecount_mapping: {
    'Bugs Created' => "filter=12504",
    'Bugs Closed' => "filter=10405",
    'Issues Opened' => "filter=19110",
    'Issues Closed' => "filter=10405"
  }
}

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

def send_info
  @info = {}
  JIRA_OPENISSUES_CONFIG[:issuecount_mapping].each do |mappingName, filter|
    total = getNumberOfIssues(JIRA_OPENISSUES_CONFIG[:jira_url], JIRA_OPENISSUES_CONFIG[:username], JIRA_OPENISSUES_CONFIG[:password], filter)
    @info[mappingName] = total
  end
  send_event('jira-scroll', { scroll_info: @info })
end

send_info

SCHEDULER.every '60s' do
  send_info
end
