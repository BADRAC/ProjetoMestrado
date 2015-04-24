class Keyword < ActiveRecord::Base
	has_and_belongs_to_many :articles

    validates :kw_name, presence: true
    
end
