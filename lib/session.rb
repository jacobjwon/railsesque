require 'json'

class Session

  def initialize(req)
    if req.cookies['_railsesque']
      @session_hash = JSON.parse(req.cookies['_railsesque'])
    else
      @session_hash = {}
    end
  end

  def [](key)
    @session_hash[key]
  end

  def []=(key, val)
    @session_hash[key] = val
  end

  def store_session(res)
    res.set_cookie('_railsesque', { path: "/", value: @session_hash.to_json } )
  end

end
