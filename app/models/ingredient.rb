# frozen_string_literal: true

class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :alcohol, presence: true

  has_many :cocktail_ingredients, class_name: 'CocktailIngredient'

  scope :alcoholic, -> { where(alcohol: true) }
end
