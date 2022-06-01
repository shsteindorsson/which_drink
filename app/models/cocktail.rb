class Cocktail < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :cocktail_ingredients, class_name: 'CocktailIngredient'
end
