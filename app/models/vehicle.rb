class Vehicle < ApplicationRecord
  validates :make, presence: true, length: { minimum: 2 }
  validates :model, presence: true, length: { minimum: 2 }
  validates :year, presence: true, length: { minimum: 4 }
end
