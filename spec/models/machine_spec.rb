require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
  end

  describe "relationships" do
    it { should belong_to :owner }
    it {should have_many(:snacks).through :machine_snacks}
    it {should have_many :machine_snacks}
  end

  describe "instance methods" do
    describe "#average_price" do
      it "should return the average price of all snacks" do
        owner = Owner.create(name: "Sam's Snacks")
        dons  = owner.machines.create(location: "Don's Mixed Drinks")
        snack_1 = dons.snacks.create(name: "Snickers", price: "1.99")
        snack_2 = dons.snacks.create(name: "Twix", price: "2.99")

        expect(dons.average_price).to eq(2.49)
      end
    end

    describe "#count_of_snacks" do
      it "does it" do
        owner = Owner.create(name: "Sam's Snacks")
        dons  = owner.machines.create(location: "Don's Mixed Drinks")
        snack_1 = dons.snacks.create(name: "Snickers", price: "1.99")
        snack_2 = dons.snacks.create(name: "Twix", price: "2.99")

        expect(dons.count_of_snacks).to eq(2)
      end
    end
  end
end
