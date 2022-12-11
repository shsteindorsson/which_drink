# frozen_string_literal: true

class Cocktail < ApplicationRecord
  validates :name, :portions, presence: true, uniqueness: true

  has_many :cocktail_ingredients, class_name: 'CocktailIngredient'
end
