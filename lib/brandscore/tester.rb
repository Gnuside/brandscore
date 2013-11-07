
module Brandscore
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
		def initialize
			@enabled_plugins = []
			yield self if block_given?
			self
		end

		def enable_plugin plugin_sym, params=nil
			@enabled_plugins << plugin_sym

			#, params
			plugin_class = Brandscore::ScoreFactory.match plugin_sym 
			pp plugin_class
			plugin = plugin_class.new params
			pp plugin
		end
		
		def exec
			pp @enabled_plugins
		end
	end
end

