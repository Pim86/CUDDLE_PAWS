class Pet < ApplicationRecord
  has_many :users
  belongs_to :owner, class_name: 'User'
end
