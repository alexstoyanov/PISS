class PrettyJsonResponse
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)

    if headers['Content-Type'] =~ /^application\/json/
      object = JSON.parse(response.body)
      string = JSON.pretty_unparse(object)
      response = [string]
      headers['Content-Length'] = Rack::Utils.bytesize(string).to_s
    end

    [status, headers, response]
  end
end
