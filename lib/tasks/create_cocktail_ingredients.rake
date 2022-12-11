# frozen_string_literal: true

require 'faraday'
require 'json'
require 'debug'

namespace :cocktail_ingredients do
  desc 'create cocktail ingredients'
  task create_cocktail_ingredients: :environment do
    ActiveRecord::Base.transaction do
      Cocktail.all.each do |cocktail|
        puts "### Building a Cocktail Ingredient Record for #{cocktail.name}"
        cocktail.portions.each do |ingr_name, portion_value|
          puts "*** Ingredient: #{ingr_name} ***"
          ingredient = find_ingredient(ingr_name.capitalize)
          cocktail.cocktail_ingredients.find_or_create_by!(
            ingredient_id: ingredient.id,
            portion: parse_portion(portion_value)
          )
        end
      end
    end
  end
end

def find_ingredient(ingr_name)
  ingredient = Ingredient.find_by('name ILIKE ?', ingr_name)
  return ingredient if ingredient

  url = URI.parse("https://www.thecocktaildb.com/api/json/v1/1/search.php?i=#{URI.encode_www_form_component(ingr_name)}")
  req = Faraday.new(url).get
  response = JSON.parse(req.body)['ingredients'].first

  Ingredient.create!(name: ingr_name,
                     description: parse_description(response['strDescription']),
                     alcohol: response['strAlcohol']&.downcase == 'yes')
end

def parse_description(value)
  return '' unless value

  value.remove('\r', '\n')
end

def parse_portion(value)
  return '' unless value

  value.strip
end
