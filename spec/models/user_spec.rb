require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "validation tests" do 
    it 'ensures first name presence' do
      user = User.new(last_name: 'last', email: 'sample@example.com').save
      expect(user).to eq(false)
    end

    it 'ensures last name presence' do
      user = User.new(first_name: 'first', email: 'sample@example.com').save
      expect(user).to eq(false)
    end

    it 'ensures email presence' do
      user = User.new(first_name: 'first', last_name: 'last').save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(first_name: 'first', last_name: 'last', email: 'sample@example.com').save
      expect(user).to eq(true)
    end
  end

  context "scope tests" do
    let! (:params) { {first_name: 'First', last_name: 'Last', email: 'sample@example.com'} }
    before(:each) do
      User.new(params).save
      User.new(params).save
      User.new(params).save
      User.new((params).merge(active: 'false')).save
      User.new((params).merge(active: 'false')).save
    end


    it 'should return active users' do
      expect(User.active_users.size).to eq(21)
    end

    it 'should return inactive users' do
      expect(User.inactive_users.size).to eq(2)
    end
  end
end
