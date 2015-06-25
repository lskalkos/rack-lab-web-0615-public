class ErbMaker
  def initialize(app)
    @app = app
  end

  def call(env)



    status, headers, response = @app.call(env)

    html = File.read('./lib/templates/index.html.erb')
    template = ERB.new(html)

    if env["PATH_INFO"] == "/about"
      body = "<h1><a href='/'>Are you lost?</a></h1>"
    else
      body = response.first + template.result(binding)
    end

    # body = response.first + template.result(binding)

    [status, headers, [body]]
  end
end