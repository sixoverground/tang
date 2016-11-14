Before do |scenario|
  StripeMock.start
end

After do |scenario|
  StripeMock.stop
end