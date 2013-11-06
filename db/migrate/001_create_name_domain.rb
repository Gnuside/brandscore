#!/usr/bin/env ruby

class CreateNameDomain < ActiveRecord::Migration
	def self.up
		create_table :names do |t|
			t.column :name, :string, :null => false
			t.column :score, :integer, :default => 0
		end

		create_table :domains do |t|
			t.column :name, :string
			t.column :tld, :string
			t.column :available, :boolean
			t.column :score, :integer, :default => 0
		end
	end

	def self.down
		drop_table :name
		drop_table :domain
	end
end
