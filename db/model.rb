
class Name < ActiveRecord::Base
	#validates_uniqueness_of :name
	has_many :domains
end

class Domain < ActiveRecord::Base
	#validates_uniqueness_of :name
end

