Before do |scenario|
  puts "MOCK STRIPE START"
  StripeMock.toggle_debug(true)
  StripeMock.start
end

After do |scenario|
  puts "MOCK STRIPE STOP"
  StripeMock.stop
end