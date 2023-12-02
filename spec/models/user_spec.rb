require 'rails_helper'

def cleanup_henok
  henok = User.where(name: 'Henok').first
  return unless henok.present?

  henok.posts.destroy_all
  henok.destroy
end

RSpec.describe User, type: :model do
  before(:each) do
    cleanup_henok
  end

  after(:all) do
    cleanup_henok
  end

  # Unit tests for name
  it '.valid should be true when name is present' do
    user = User.new(name: 'Henok', email: 'henok1234@example.com', password: '123456')
    expect(user).to be_valid
  end

  it '.valid should be false when name is not present' do
    user = User.new
    expect(user).to_not be_valid
  end
  ######
end
