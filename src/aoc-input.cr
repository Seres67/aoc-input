# TODO: Write documentation for `Aoc::Input`

require "http/client"
require "http/cookie"
require "http/request"
require "http/status"
require "uri"

module AOC::Input
  VERSION = "0.1.0"

  # Returns the input for selected day and year
  #
  # environment variable AOC_SESSION must be set to your session token
  def get_input(day, year)
    session_token = ENV["AOC_SESSION"]?
    if session_token.nil?
      raise "set env var AOC_SESSION to your aoc session cookie"
    end
    request = HTTP::Request.new("GET", "/#{year}/day/#{day}/input")
    request.cookies << HTTP::Cookie.new("session", session_token)
    client = HTTP::Client.new(URI.parse("https://adventofcode.com"))
    resp = client.exec(request)
    if resp.status != HTTP::Status::OK
      raise "error receiving input"
    end
    resp.body
  end
end
