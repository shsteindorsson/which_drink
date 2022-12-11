# frozen_string_literal: true

class CocktailIngredient < ApplicationRecord
  validates :portion, presence: true

  belongs_to :cocktail # , class_name: 'Cocktail', optional: true
  belongs_to :ingredient # , class_name: 'Ingredient'
end
