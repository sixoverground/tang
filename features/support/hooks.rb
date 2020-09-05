Before do |scenario|
  StripeMock.toggle_debug(true)
  StripeMock.start
end

After do |scenario|
  StripeMock.stop
end