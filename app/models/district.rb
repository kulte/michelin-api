class District < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :restaurants
end
