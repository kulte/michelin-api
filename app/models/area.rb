class Area < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :restaurants
end
