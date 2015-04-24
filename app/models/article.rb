class Article < ActiveRecord::Base
  belongs_to :edition
  
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :keywords

  #validates :title, :abstract, presence: true
  validates :title, presence: true
  validates :url,
  			presence: true, 
  			format: { with: /http:|https:/, 
  			message: "Obrigatório o uso de http://www. ou https://www." }
end