require 'octokit'

event = ENV['INPUT_EVENT']
# org = ENV['GITHUB_REPOSITORY'].split('/').first
org = "jerry81/actions-practice"
client = Octokit::Client.new(access_token: ENV['INPUT_TOKEN'], per_page: 100)
client.auto_paginate = true

payload = {
  headers: { accept: 'application/vnd.github.v3+json' },
  query: {
    type: 'private'
  }
}

repos_to_notify = client.organization_repositories(org, payload).select{|repo| repo.archived == false}.map(&:full_name)

payload = {
  event_type: event
}

repos_to_notify.each do |repo|
  puts "Notifying #{repo} with event #{event}..."
  client.post("/repos/#{repo}/dispatches", payload)
rescue Octokit::NotFound => e
  puts "For #{repo} the following error occurred: #{e}"
end
