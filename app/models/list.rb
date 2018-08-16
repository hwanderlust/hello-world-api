class List < ApplicationRecord
  has_many :messages
  belongs_to :user 
end
