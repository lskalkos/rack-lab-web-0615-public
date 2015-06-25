require_relative '../spec_helper'
require 'pry'

describe 'Application' do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  it_behaves_like "an ok request"
  
  let(:expected_stuff) {[
    "<html>",
    "GET",
    "80",
    "<body>"
  ]}

  it 'returns html containing the correct elements' do
    # First test to see that correct elements exist
    expected_stuff.each do |element|
      expect(last_response.body).to match(/#{element}/)
    end

    # Then do crazy stuff to see if there is some random number between 1 and 1000
    # included in the response HTML
    num_match = (1..1000).map {|num| last_response.body.match(/#{num}/)}.detect do |m|
      m
    end

    expect(num_match).to_not be_nil
  end

  it 'returns an "Are you lost?" message at /about' do
    get '/about'
    expect(last_response.body).to eq("<h1><a href='/'>Are you lost?</a></h1>")
  end
end