#!/var/vcap/bosh/bin/ruby

require 'optparse'
require 'fileutils'
require 'uuidtools'

$config_file = nil
def start
  #puts "call start"
  config = YAML.load_file($config_file)
  log_file = File.join(config["output_dir"], UUIDTools::UUID.random_create.to_s + ".log")
  File.open(log_file, 'w') do |f|
    f.puts(config.inspect)
  end

  pid = fork
  if pid
    sleep 0.1
  else
    exec "/var/vcap/data/density_test/package/redis-benchmark -h #{config["credential"]["host"]} -a #{config["credential"]["password"]} -p #{config["credential"]["port"]} -c #{config["load_setting"]["conn"]} -n 1000 -r 1000 -l -i 2000 -R >/dev/null 2>#{log_file} &"
  end
end

def stop
  #puts "call stop"
  `pkill -f redis-benchmark`
end

optparse = OptionParser.new do |opts|
  opts.on("-c [ARG]", "Config file") do |opt|
    $config_file = opt
  end
end
optparse.parse!

send(ARGV[0].to_sym)
