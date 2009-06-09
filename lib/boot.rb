require 'rubygems'

# db
require 'lib/db'

# twitter
require 'lib/twitter'

# include models
Dir["models/*.rb"].each do |model|
	require model
end

