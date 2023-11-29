require 'rails_helper'

def cleanup_henok
  henok = User.where(name: 'Henok').first
  return unless henok.present?

  henok.destroy
end

def cleanup_bread
  grocery = Category.where(name: 'Grocery').first
  return unless grocery.present?

  grocery.destroy
end

RSpec.describe Expense, type: :model do
  before(:each) do
    cleanup_henok
    cleanup_bread
  end

  after(:all) do
    cleanup_henok
    cleanup_bread
  end

  # Unit tests for author
  it '.valid should be true when author is present' do
    user = User.create(name: 'Henok')
    expense = Expense.new(name: 'Bread', author: user, amount: 10)
    expect(expense).to be_valid
  end

  it '.valid should be false when author is NOT present' do
    User.create(name: 'Henok')
    expense = Expense.new(name: 'Bread', amount: 10)
    expect(expense).to_not be_valid
  end
  #####

  # Unit tests for name
  it '.valid should be true when name is present' do
    user = User.create(name: 'Henok')
    expense = Expense.new(name: 'Bread', author: user, amount: 10)
    expect(expense).to be_valid
  end

  it '.valid should be false when name is NOT present' do
    user = User.create(name: 'Henok')
    expense = Expense.new(author: user, amount: 10)
    expect(expense).to_not be_valid
  end
  #####

  # Unit tests for amount
  it '.valid should be true when amount is present' do
    user = User.create(name: 'Henok')
    expense = Expense.new(name: 'Bread', author: user, amount: 10)
    expect(expense).to be_valid
  end

  it '.valid should be false when amount is NOT present' do
    user = User.create(name: 'Henok')
    expense = Expense.new(name: 'Bread', author: user)
    expect(expense).to_not be_valid
  end

  it '.valid should be false when amount is zero' do
    user = User.create(name: 'Henok')
    expense = Expense.new(name: 'Bread', author: user, amount: 0)
    expect(expense).to_not be_valid
  end

  it '.valid should be false when amount is a negative number' do
    user = User.create(name: 'Henok')
    expense = Expense.new(name: 'Bread', author: user, amount: -10)
    expect(expense).to_not be_valid
  end

  it '.valid should be false when amount is NOT a number' do
    user = User.create(name: 'Henok')
    expense = Expense.new(name: 'Bread', author: user, amount: 'Hello')
    expect(expense).to_not be_valid
  end
  #####
end
