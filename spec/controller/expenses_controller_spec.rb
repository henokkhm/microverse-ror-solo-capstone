require 'rails_helper'

RSpec.describe ExpensesController, type: :routing do
  before(:each) do
    Expense.delete_all
    Category.delete_all
    User.delete_all
    @user = User.create(name: 'Henok', email: 'henok1234@example.com', password: '123456')
    @category = Category.create(name: 'Food', icon: '🍴', user: @user)
    @expense = Expense.create(name: 'Burger', amount: 10, categories: [@category], author: @user)
  end

  describe 'routing' do
    it 'routes to #new' do
      expect(get: 'categories/1/expenses/new').to route_to('expenses#new', category_id: '1')
    end

    it 'routes to #edit' do
      expect(get: 'categories/1/expenses/2/edit').to route_to('expenses#edit', category_id: '1', id: '2')
    end

    it 'routes to #create' do
      expect(post: 'categories/1/expenses').to route_to('expenses#create', category_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'categories/1/expenses/2').to route_to('expenses#update', category_id: '1', id: '2')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'categories/1/expenses/2').to route_to('expenses#update', category_id: '1', id: '2')
    end

    it 'routes to #destroy' do
      expect(delete: 'categories/1/expenses/2').to route_to('expenses#destroy', category_id: '1', id: '2')
    end
  end
end
