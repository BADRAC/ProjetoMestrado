class Edition < ActiveRecord::Base
	belongs_to :journal
	has_many :articles

	validates :e_name, presence: true, uniqueness: true
end
