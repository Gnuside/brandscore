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

	# All plugins will inherit from this class
	class GenericScore
		# Initialize score plugin with parameters
		#
		#   GenericScore.new :api_key => "xxx",
		#       :base_url => "yyy", ...
		# 
		def initialize params
			raise NotImplementedError
		end

		def test 
		end
	end

	# A tester is a object for testing multiple brands
	# with various plugins.
	#
	# Simply enable plugins, load the names, run the test !
	class Tester
		# Create a tester with given plugins
		#
		#   web_tester = Brandscore.create_tester do |tester|
		#    t.enable :dns, { dns score parameters ... }
		#    t.enable :google, { google score parameters ...}
		#    ...
		#  end
		#
		def self.create_tester

		end
		def initialize
		end

		def enable plugin_sym
			Brandscore::Factory.plugins.select do |plugin|
				plugin.
			end
		end
	end


end
