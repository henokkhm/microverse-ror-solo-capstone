require 'rails_helper'

RSpec.describe '/categories', type: :feature do
  before(:each) do
    Expense.delete_all
    Category.delete_all
    User.delete_all
    @henok = User.create(name: 'Henok', email: 'henok1234@example.com', password: '123456')
    @food = Category.create(name: 'Food', icon: '🍴', user: @henok)
    @travel = Category.create(name: 'Travel', icon: '🚗', user: @henok)
    @apples = Expense.create(name: 'Apples', amount: 10, categories: [@food], author: @henok)
    @bus_fare = Expense.create(name: 'Bus fare', amount: 20, categories: [@food, @travel], author: @henok)

    visit new_user_session_path
    fill_in 'Email', with: 'henok1234@example.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    sleep(1)
    visit(categories_path)
  end

  it 'has successful response' do
    expect(page).to have_http_status(:ok)
  end

  it 'has a list of categories' do
    expect(page).to have_content('Food')
    expect(page).to have_content('Travel')
  end

  it 'allows the user to create a new category' do
    click_link 'Add New Category'
    fill_in 'Name', with: 'Housing'
    select '🏠', from: 'Icon'
    click_button 'Save'
    sleep(1)
    expect(page).to have_content('Housing')
    expect(page).to have_content('🏠')
  end

  it 'allows the user to edit a category' do
    food_id = @food.id
    find("#edit-category-#{food_id}-link").click
    fill_in 'Name', with: 'Savings'
    select '🍴', from: 'Icon'
    click_button 'Save'
    sleep(1)
    expect(page).to have_content('Savings')
    expect(page).to have_content('🍴')
  end

  it 'allows the user to delete a category' do
    food_id = @food.id
    find("#edit-category-#{food_id}-link").click
    sleep(1)
    expect(page).to_not have_content('Food')
  end
end
