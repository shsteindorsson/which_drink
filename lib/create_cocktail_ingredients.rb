def find_ingredient_id(iname)
  Ingredient.all.find_by(name: iname).id
end

Cocktail.all.each do |cocktail|
  puts "### Building join-table for #{cocktail.name}"
  cocktail.portions.each do |ingredient, portion|
    CocktailIngredient.create!(
      cocktails_id: cocktail.id,
      ingredients_id: find_ingredient_id(ingredient),
      portion: portion
    )
  end
end
