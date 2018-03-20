require 'rails_helper'

RSpec.describe Supplier, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:organization_id) }
  it { should accept_nested_attributes_for(:addresses) }
  it { should accept_nested_attributes_for(:phones) }
  it { should accept_nested_attributes_for(:contacts) }
  it { should belong_to(:organization) }
  it { should have_many(:products) }
  it { should have_many(:contacts) }
  it { should have_many(:addresses) }
  it { should have_many(:phones) }

  it 'validate end after the start date ' do
    @supplier = FactoryGirl.build(:supplier, :start_date => "2015-3-10", :end_date => "2015-3-9")
    @supplier.valid?
    @supplier.errors.any?
    expect(@supplier.errors[:end_date]).to be == ['must be after the start date']
  end
end
