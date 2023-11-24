class User < ApplicationRecord
  validates :name, presence: true

  has_many :categories
end
