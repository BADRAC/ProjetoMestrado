class Author < ActiveRecord::Base
  has_and_belongs_to_many :books
  has_and_belongs_to_many :articles

  validates :first_name, :last_name,
  			presence: true, 
  			format: { with: /\A[a-zA-Z]+\z/, message: "Usar apenas letras" }
end
