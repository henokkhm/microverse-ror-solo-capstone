class Category < ApplicationRecord
  validates :name, presence: true
  validates :icon, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_and_belongs_to_many :expenses, join_table: :expenses_categories
end
