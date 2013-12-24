class OptionsController < ApplicationController

  def options
    headers['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Headers, Access-Control-Allow-Methods, Access-Control-Allow-Origin, Access-Control-Expose-Headers, Allow, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, Api-Version, Response-Time'
    headers['Access-Control-Allow-Methods'] = 'GET,POST,OPTIONS'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'Access-Control-Allow-Headers, Access-Control-Allow-Methods, Access-Control-Allow-Origin, Access-Control-Expose-Headers, Allow, Api-Version, Request-Id, Response-Time'
    headers['Allow'] = 'GET,POST,OPTIONS'

    render :nothing => true
  end

end