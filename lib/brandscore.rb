
require 'brandscore/score_factory'
require 'brandscore/dns_score'

require 'brandscore/tester'

module Brandscore
	# List available Brandscore plugins
	#
	#   Factory.plugins
	#   => { 
	#     :google => GoogleScore, 
	#     :dns => DnsScore, 
	#     :twitter => TwitterScore,
	#     :facebook => FacebookScore,
	#     :fr_companies => FrSocieteScore,
	#   }
	#
	def self.plugins
	end

end

