require 'rails_helper'

RSpec.describe Contract, type: :model do

  it { should belong_to(:customer) }
  it { should belong_to(:organization) }
  it { should have_many(:projects).dependent(:destroy) }
  it { should accept_nested_attributes_for(:projects).allow_destroy(true) }
  it { should validate_presence_of(:customer) }

end
