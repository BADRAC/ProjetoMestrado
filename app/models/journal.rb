class Journal < ActiveRecord::Base
	has_many :editions
	
	validates :j_name, presence: true, uniqueness: true


	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |exp|
      			csv << exp.attributes.values_at(*column_names)
    		end
  		end
  	end
end

