# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(Ingredient.new(
               name: 'Vodka',
               alcohol: true
             )).to be_valid
    end
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:alcohol) }
    it { should have_many(:cocktail_ingredients) }
  end
end
