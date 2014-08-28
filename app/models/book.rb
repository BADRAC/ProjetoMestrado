class Book < ActiveRecord::Base
  belongs_to :edition
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :keywords
end
