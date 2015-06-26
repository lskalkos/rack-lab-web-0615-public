class ErbMaker
  def initialize(app)
    @app = app
  end

  def template_string
    html = File.read('./lib/templates/index.html.erb')
    template = ERB.new(html)
    template.result(binding)
  end

  def lost_message_string
    "<h1><a href='/'>Are you lost?</a></h1>"
  end

  def set_body(path, last_response)
    path == "/about" ? lost_message_string : last_response + template_string
  end

  def call(env)
    status, headers, response = @app.call(env)

    body = set_body(env["PATH_INFO"], response.first)

    [status, headers, [body]]
  end
end