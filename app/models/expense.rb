class Expense < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :name, presence: true
  validates :amount, numericality: { greater_than: 0 }

  has_and_belongs_to_many :categories, join_table: :expenses_categories
end
