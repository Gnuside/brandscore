
require 'whois'
require 'resolv'

module Brandscore
	class DnsScore < GenericScore
		def self.match? pattern
			pattern =~ /^dns$/
		end

		def initialize hash

			@tlds = {
				"com" => 7, 
				"net" => 7, 
				"fr" => 3, 
				"de" => 3, 
				"us" => 3,
				"org" => 1
			}
		end

		def domain_free? dns
			begin
				Resolv.getaddress dns
				return false
			rescue Resolv::ResolvError
				c = Whois.query dns
				return (not c.registered?)
			end
		end

		def domain_value dns
			tld = dns.gsub /^.*\.(.+?)$/, '\1'
			return @tlds[tld].to_i
		end

		def domain_each root
			@tlds.keys.sort{ |a,b| -( @tlds[a] <=> @tlds[b] ) }.each do |tld|
				yield "%s.%s" % [ root, tld ]
			end
		end


		def domain_run name
			ActiveRecord::Base.transaction do
				n = Name.find( :first, :conditions => { :name => name } ) ||
					Name.create( :name => name )
			end
			n.save!
			domain_each( name ) do |dns|
				src = :old
				d = Domain.find :first, :conditions => { :name => dns }
				if d.nil? then
					src = :new
					d = Domain.create :name => dns
					if domain_free? dns then 
						d.score = domain_value dns
						d.available = true
						n.score += d.score
					else 
						d.available = false
					end
					ActiveRecord::Base.transaction do
						d.save!
						n.save!
					end
				end

				mesg = if d.available then " OK "
					   else "FAIL"
					   end
				puts " [%s] %s (%s)" % [ mesg, dns, src ]
				STDOUT.flush
				sleep 4 if src == :new
			end
			puts "=> #{n.name} : #{n.score} points"
		end

		def run
			begin
				while true
					STDERR.print "Name? "
					begin
						name = STDIN.readline.strip
						next if name =~ /^\s*$/
						puts "#{name}"
						name.gsub!(/[^a-zA-Z0-9]/,'-')

						domain_run name
					rescue Interrupt => e
						STDERR.puts ""
					end
				end

			rescue EOFError
				exit 0
			end
		end

	end
end

#dt = DnsTester.new
#dt.run

