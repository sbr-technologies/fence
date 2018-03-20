require 'rails_helper'

RSpec.describe ProductRate, type: :model do
  it 'cost price must be less than or equal to retail price' do
    product_rate = FactoryGirl.create(:product_rate, cost: 10, retail: 11 )
    expect(product_rate.valid?).to be(true)
  end
end
