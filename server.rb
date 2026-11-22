# encoding: utf-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'webrick'

server = WEBrick::HTTPServer.new(
  Port: 8000,
  BindAddress: '0.0.0.0',
  Logger: WEBrick::Log.new($stdout, WEBrick::Log::INFO),
  AccessLog: []
)

server.mount_proc '/' do |req, res|
  rel = req.path == '/' ? 'index.html' : req.path.sub(/^\//, '')
  file_path = File.expand_path(rel, '.')
  
  if File.file?(file_path)
    ext = File.extname(file_path).downcase
    content_type = case ext
      when '.html', '.htm' then 'text/html; charset=utf-8'
      when '.js'          then 'application/javascript; charset=utf-8'
      when '.css'         then 'text/css; charset=utf-8'
      when '.json'        then 'application/json; charset=utf-8'
      when '.csv'         then 'text/csv; charset=utf-8'
      when '.png'         then 'image/png'
      when '.jpg', '.jpeg' then 'image/jpeg'
      when '.svg'         then 'image/svg+xml'
      else 'application/octet-stream'
    end
    res['Content-Type'] = content_type
    res.body = File.binread(file_path)
  else
    res.status = 404
    res['Content-Type'] = 'text/plain; charset=utf-8'
    res.body = "File not found: #{req.path}"
  end
end

trap('INT') { server.shutdown }
trap('TERM') { server.shutdown }

server.start
