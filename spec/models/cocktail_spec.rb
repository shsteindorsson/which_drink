# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cocktail, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(Cocktail.new(
               name: 'Screwdriver',
               portions: { 'Vodka' => '1 part', 'Orange juice' => '2 parts' }
             )).to be_valid
    end
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:portions) }
    it { should have_many(:cocktail_ingredients) }
  end
end
