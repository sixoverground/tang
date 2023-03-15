Before do
  StripeMock.toggle_debug(true)
  StripeMock.start
end

After do
  StripeMock.stop
end
