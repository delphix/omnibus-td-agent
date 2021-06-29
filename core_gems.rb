dir 'core_gems'
download "bundler", "1.16.6"
download "msgpack", "1.3.3"
if td_agent_2?
  download "cool.io", "1.5.1"
  download "oj", "2.18.5"
else
  download "cool.io", "1.6.0"
  download 'serverengine', '2.2.2'
  download "oj", "3.8.1"
  download "console", "1.8.2"
  # To stay on Ruby 2.4.
  download "protocol-http", "0.15.1"
  download "protocol-http2", "0.11.6"
  # To prevent nio4r's native extension building error
  # due to devkit requiring forcibly.
  # ref: https://github.com/socketry/nio4r/blob/master/ext/nio4r/extconf.rb#L7
  download "nio4r", "2.5.2"
  download "async", "1.24.2"
  download "async-io", "1.27.7"
  download "async-pool", "0.2.0"
  download "async-http", "0.50.8"
end
download "http_parser.rb", "0.6.0"
download "yajl-ruby", "1.4.1"
download "sigdump", "0.2.4"
download "tzinfo", "2.0.3"
download "tzinfo-data", "1.2020.4"
if windows?
  download 'ffi', '1.13.1'
  download 'ffi-win32-extensions', '1.0.3'
  download 'win32-ipc', '0.7.0'
  download 'win32-event', '0.6.3'
  download 'win32-service', '2.1.5'
  download 'win32-api', '1.8.0-universal-mingw32'
  download 'windows-pr', '1.2.6'
  download 'windows-api', '0.4.4'
end
