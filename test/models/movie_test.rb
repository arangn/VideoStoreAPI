require "test_helper"
require 'pry'

describe Movie do
  let(:elf) { movies(:one) }
  let(:movie) { Movie.new }

  it "must be valid" do
    value(elf).must_be :valid?
  end

  it "requires title, overview, release_date, and inventory" do
    required_fields = [:title, :overview, :release_date, :inventory]

    required_fields.each do |field|
      elf[field] = nil
      expect(elf.valid?).must_equal false
      elf.reload
    end
  end

  it "requires a numeric inventory" do
    elf.inventory = "string"
    expect(elf.valid?).must_equal false
  end

  # describe "relations" do
  #   it 'has many rentals' do
  #     expect(elf.rentals).must_be_kind_of Rental
  #   end
  # end
end


# describe 'relations' do
#   it 'has an order' do
#     cart_entry = cart_entries(:entry)
#     cart_entry.order.must_equal orders(:persons_order)
#   end
