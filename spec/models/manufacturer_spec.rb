require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  it { should belong_to(:organization) }
  it { should have_many(:contacts) }
  it { should have_many(:phones) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:number).scoped_to(:organization_id) }
  it { should validate_uniqueness_of(:name).scoped_to(:organization_id) }
  it { should accept_nested_attributes_for(:addresses)}
  it { should accept_nested_attributes_for(:phones)}

  it 'validate end after the start date ' do
    @manufacturer = FactoryGirl.build(:manufacturer, :start_date => "2015-3-10", :end_date => "2015-3-9")
    @manufacturer.valid?
    @manufacturer.errors.any?
    expect(@manufacturer.errors[:end_date]).to be == ['must be after the start date']
  end
end
