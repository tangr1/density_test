require "eventmachine"

puts `./client upload`
EM.run do
  puts `./client start`
  EM.add_timer(300) do
    puts `./client stop`
    EM.stop
  end
end
puts `ruby response_time.rb`
`mv output #{ARGV[0]}`
`./client clean_all`
