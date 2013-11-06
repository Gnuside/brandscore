#!/usr/bin/env ruby

$:.insert 0, '.'

require 'bundler/setup'

require 'whois'
require 'logger'
require 'resolv'
require 'active_record'
require 'db/model'
require 'thor'

database_config = {
	:adapter  => 'sqlite3',
	:database => 'dns.db'
}

ActiveRecord::Base.establish_connection(database_config)

#ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger = Logger.new( "debug.log" )
ActiveRecord::Migrator.up('db/migrate') 

class BrandScore < Thor
	package_name "Brand Score" 

	option :plugins, :type => :string, :aliases => "-p"
	desc "search [FILE]", "Score name from a file"
	def search file
		puts "[options %s]" % options.inspect
		puts "searching file %s" % file
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
BrandScore.start(ARGV)

#dt = DnsLister.new
#dt.run

