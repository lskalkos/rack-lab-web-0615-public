require_relative '../spec_helper'
require 'pry'

describe 'RandomNumber Middleware' do
  def app
    RandomNumber.new(Application.new)
  end
  
  it_behaves_like "an ok request"

  it 'adds a random number to the response' do
    expect(last_response.body.split(' - ').map {|e| e.to_i.to_s == e}).to include(true)
  end
end