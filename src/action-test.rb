require 'octokit'

event = 'blahblah'
org = 'jerry81'

client = Octokit::Client.new(access_token: ENV['INPUT_TOKEN'], per_page: 100)
client.auto_paginate = true

payload = {
  headers: { accept: 'application/vnd.github.v3+json' },
  query: {
    # type: 'public'
  }
}

# repos_to_notify = client.organization_repositories(org, payload).select{|repo| repo.archived == false}.map(&:full_name)

# puts "repos_to_notify are #{repos_to_notify}"
payload = {
headers: { accept: 'application/vnd.github.v3+json' },
  event_type: event
}

repo = 'jerry81/actions-practice'

client.post("/repos/#{repo}/dispatches", payload)

# repos_to_notify.each do |repo|
#   puts "Notifying #{repo} with event #{event}..."
#   client.post("/repos/#{repo}/dispatches", payload)
# rescue Octokit::NotFound => e
#   puts "For #{repo} the following error occurred: #{e}"
# end
