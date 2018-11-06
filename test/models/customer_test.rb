require "test_helper"

describe Customer do
  let(:petunia_picklepants) { customers(:three) }


  it "must be valid" do
    value(petunia_picklepants).must_be :valid?
  end

  it "requires name, registered_at, address, city, state, postal code, phone" do
    required_fields = [:name, :registered_at, :address, :city, :state, :postal_code, :phone]

    required_fields.each do |field|
      petunia_picklepants[field] = nil

      expect(petunia_picklepants.valid?).must_equal false

      petunia_picklepants.reload
    end
  end


  describe 'relations' do
    it 'has many rentals' do
      expect(petunia_picklepants).must_respond_to :rentals
    end

    it 'has many movies' do
      expect(petunia_picklepants).must_respond_to :movies
    end

  end

end
