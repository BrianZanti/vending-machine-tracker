require "rails_helper"

RSpec.describe "the snack show page" do
  before :each do
    @sam = Owner.create(name: "Sam's Snacks")
    @dons = @sam.machines.create(location: "Don's Mixed Drinks")
    @turing = @sam.machines.create(location: "Turing Basement")
    @snickers = @dons.snacks.create(name: "Snickers", price: 2.99)
    @turing.snacks << @snickers
    @turing.snacks.create(name: "Reeses", price: 0.99)

    visit snack_path(@snickers)
  end

  it "should list the snack name and price" do
    expect(page).to have_content(@snickers.name)
    expect(page).to have_content(@snickers.price)
  end

  it "should list all locations with the average price" do
    expect(page).to have_content(@dons.location)
    expect(page).to have_content(@dons.average_price)
    expect(page).to have_content(@turing.location)
    expect(page).to have_content(@turing.average_price)
  end

  it "should list all locations with the summary of snack counts" do
    expect(page).to have_content("#{@dons.count_of_snacks} types of snacks")
    expect(page).to have_content("#{@turing.count_of_snacks} types of snacks")
  end
end
