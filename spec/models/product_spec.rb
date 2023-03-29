require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context "when validating product properties" do
      #let(:category) { Category.create(name: "Evergreens") }
      #let(:product) { Product.create(name: "Peashooter", price: 9.99, quantity: 10, category: category) }
    
      it "should be valid with valid properties" do
        @category = Category.create(name: "Evergreens")
        @product = Product.create(name: "Peashooter", price: 9.99, quantity: 10, category: @category)
        expect(@product).to be_valid
      end
    
      it "should be invalid without a name" do
        @category = Category.create(name: "Bushes")
        @product = Product.create(name: nil, price: 15.45, quantity: 2, category: @category)
        expect(@product).not_to be_valid
        expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
      end

      it "should be invalid without a price" do
        @category = Category.create(name: "Vegetable")
        @product = Product.create(name: "Squash", price_cents: nil, quantity: 3, category: @category)
        expect(@product).not_to be_valid
        expect(@product.errors.full_messages[2]).to eq("Price cents can't be blank")
      end
  
      it "should be invalid without a quantity" do
        @category = Category.create(name: "Bushes")
        @product = Product.create(name: "Jalapeno", price: 9.99, quantity: nil, category: @category)
        expect(@product).not_to be_valid
        expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
      end
  
      it "should be invalid without a category" do
        @category = Category.create(name: "Fruit")
        @product = Product.create(name: "Squash", price: 9.34, quantity: 3, category: nil)
        #byebug can be used anytime to stop the code, press "c" to continue
        expect(@product).not_to be_valid
        expect(@product.errors.full_messages[0]).to eq("Category must exist")
      end
    end
  end
end
