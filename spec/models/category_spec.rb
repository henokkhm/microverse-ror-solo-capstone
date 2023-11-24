require 'rails_helper'

def cleanup_henok
  henok = User.where(name: 'Henok').first
  return unless henok.present?

  henok.destroy
end

def cleanup_grocery
  grocery = Category.where(name: 'Grocery').first
  return unless grocery.present?

  grocery.destroy
end

RSpec.describe Category, type: :model do
  before(:each) do
    cleanup_henok
  end

  after(:all) do
    cleanup_henok
  end

  # Unit tests for name
  it '.valid should be true when name and icon url are present' do
    user = User.create(name: 'Henok')
    category = Category.new(name: 'Grocery', user:, icon_url: 'https://www.flaticon.com/free-icons/groceries')
    expect(category).to be_valid
  end

  it '.valid should be false when user is not present' do
    category = Category.new(name: 'Grocery', icon_url: 'https://www.flaticon.com/free-icons/groceries')
    expect(category).to_not be_valid
  end

  it '.valid should be false when name is not present' do
    user = User.create(name: 'Henok')
    category = Category.new(user:, icon_url: 'https://www.flaticon.com/free-icons/groceries')
    expect(category).to_not be_valid
  end

  it '.valid should be false when icon url is not present' do
    user = User.create(name: 'Henok')
    category = Category.new(name: 'Grocery', user:)
    expect(category).to_not be_valid
  end
  ######
end
