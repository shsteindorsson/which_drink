class CocktailIngredient < ApplicationRecord
  belongs_to :cocktail, class_name: 'Cocktail'
  belongs_to :ingredients, class_name: 'Ingredient'
end
