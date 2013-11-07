#!/usr/bin/env ruby

$:.insert 0, '.'
$:.insert 0, 'lib'

require 'bundler/setup'

require 'whois'
require 'logger'
require 'resolv'
require 'active_record'
require 'db/model'
require 'thor'
require 'pry'

require 'brandscore'

database_config = {
	:adapter  => 'sqlite3',
	:database => 'dns.db'
}

ActiveRecord::Base.establish_connection(database_config)

#ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger = Logger.new( "debug.log" )
ActiveRecord::Migrator.up('db/migrate') 

module Brandscore
	class CLI < Thor
		package_name "Brand Score" 

		option :plugins, :type => :string, :aliases => "-p"
		desc "search [FILE]", "Score name from a file"
		def search file
			puts "[options %s]" % options.inspect
			puts "searching file %s" % file

			# FIXME: search matching plugins
			tester = Brandscore::Tester.new do |tester|
				proposed_plugins = options[:plugins].split(/,/)
				proposed_plugins.each do |plugin_name|
					puts "enable plugin %s" % plugin_name
					tester.enable_plugin plugin_name
				end
			end
			tester.exec
		end

		desc "list", "List scores results"
		def list
			r = Name.where("score >= 16").order(score: :desc)
			lastscore = 0
			r.each do |t|
				if t.score != lastscore then
					puts ""
					puts "---- score #{t.score} ----"
				end
				puts "\t#{t.name}"
				lastscore = t.score
			end
		end
	end
end

Brandscore::CLI.start(ARGV)

#dt = DnsLister.new
#dt.run

