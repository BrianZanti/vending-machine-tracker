require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  it 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  it 'they see the name of all of the snacks associated with that vending machine along with their price' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create(name: "Snickers", price: "1.99")
    snack_2 = dons.snacks.create(name: "Twix", price: "2.99")

    visit machine_path(dons)

    expect(page).to have_content(snack_1.name)
    expect(page).to have_content(snack_2.name)
    expect(page).to have_content(snack_1.price)
    expect(page).to have_content(snack_2.price)
  end

  it "they see an average price for all of the snacks in that machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create(name: "Snickers", price: "1.99")
    snack_2 = dons.snacks.create(name: "Twix", price: "2.99")

    visit machine_path(dons)

    expect(page).to have_content("Average Price: 2.49")
  end
end
