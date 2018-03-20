require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'Organization can be created without address' do
    expect(Organization.count).to be(0)
    organization = FactoryGirl.build(:organization)
    expect(organization.valid?).to be(true)
    organization.save
    expect(Organization.count).to be(1)
  end

  it 'should have atleast one address while updating' do
    expect(Organization.count).to be(0)
    organization = FactoryGirl.create(:organization)
    expect(organization.valid?).to be(false)
    expect(organization.errors[:base]).to eq([I18n.t('organization.atleast_one_address_and_phone')])
    organization.address = FactoryGirl.build :address
    expect(organization.errors[:base]).to eq([I18n.t('organization.atleast_one_address_and_phone')])
    organization.phones = [FactoryGirl.build(:phone)]
    expect(organization.valid?).to be(true)
    organization.save
    expect(Organization.count).to be(1)
  end
end
