
module Brandscore
	class GenericScore
		def self.match? pattern
			raise NotImplementedError
		end
	end

	class ScoreFactory
		class UndefinedPluginError < RuntimeError ; end

		def self.match plugin_sym
			all_plugins = ObjectSpace.each_object(::Class).select { |klass| klass < GenericScore }
			plugin_class = all_plugins.select { |plugin| plugin.match? plugin_sym.to_s }.first
			raise UndefinedPluginError if plugin_class.nil?
			return plugin_class
		end
	end
end
