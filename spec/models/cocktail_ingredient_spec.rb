# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CocktailIngredient, type: :model do
  describe 'validations' do
    let(:cocktail) do
      create(:cocktail,
             name: 'Screwdriver',
             portions: { 'Vodka' => '1 part',
                         'Orange juice' => '2 parts' })
    end
    let(:ingredient) { create(:ingredient, name: 'Vodka', alcohol: true) }
    it 'is valid with valid attributes' do
      expect(CocktailIngredient.new(
               portion: '1 part',
               cocktail_id: cocktail.id,
               ingredient_id: ingredient.id
             )).to be_valid
    end
    it { should validate_presence_of(:portion) }
    it { should belong_to(:cocktail) }
    it { should belong_to(:ingredient) }
  end
end
