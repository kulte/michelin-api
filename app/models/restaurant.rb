class Restaurant < ActiveRecord::Base
  include Filterable

  validates :name, :stars, :comfort, presence: true
  validates :stars, inclusion: 1..3
  validates :comfort, inclusion: 1..5

  belongs_to :district
  belongs_to :area

  scope :stars, -> (stars) { where(stars: stars) }
  scope :comfort, -> (comfort) { where(comfort: comfort) }
  scope :chef, -> (chef) { where(chef: chef) }
end
