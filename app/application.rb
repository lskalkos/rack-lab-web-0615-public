require 'pry'

class Application

  def call(env)

      body = "<html>"

    [200, {'Content-Type' => 'text/html'}, [body]]
  end
end



