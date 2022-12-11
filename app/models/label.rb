class Label < ApplicationRecord
  has_many :tidies, dependent: :destroy
  has_many :tasks, through: :tidies
end
