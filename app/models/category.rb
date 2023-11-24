class Category < ApplicationRecord
  validates :name, presence: true
  validates :icon_url, presence: true
  validates :user_id, presence: true

  belongs_to :user
end
