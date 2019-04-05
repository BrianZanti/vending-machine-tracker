class Snack < ApplicationRecord
  validates_presence_of :price,
                        :name

  has_many :machine_snacks
  has_many :machines, through: :machine_snacks
end
