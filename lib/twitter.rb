gem 'twitter'; require 'twitter'

begin
	@@config = YAML::load(open('lib/config'))
rescue
	# write sample
	File.open('lib/config', 'w') { |f| f.write({ 'key' => 'edit', 'secret' => 'edit' }.to_yaml) }
	
	puts "Please edit 'lib/config'"
	exit
end
