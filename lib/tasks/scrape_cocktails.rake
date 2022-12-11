# frozen_string_literal: true

require 'faraday'
require 'json'

# Append id to fetch cocktail data
COCKTAIL_URL = 'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i='
# Append ingredient name to fetch cocktail id's
DRINK_ID_URL = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i='

namespace :cocktails do
  desc 'scrape cocktails'
  task scrape_cocktails: :environment do
    cocktail_id_collection = []

    Ingredient.select(&:alcohol).each do |ingredient|
      # Responds with a collection of cocktail IDs
      ascii_name    = URI.encode_www_form_component(ingredient.name)
      id_response   = Faraday.new(DRINK_ID_URL + ascii_name).get
      JSON.parse(id_response.body)['drinks'].map { |d| cocktail_id_collection << d['idDrink'] }
    end

    ActiveRecord::Base.transaction do
      cocktail_id_collection.uniq.each do |id|
        response = Faraday.new(COCKTAIL_URL + id).get
        drink = JSON.parse(response.body)['drinks'].last

        puts "### Building: #{drink['strDrink']}"

        Cocktail.create!(
          name: drink['strDrink'],
          instructions: drink['strInstructions'],
          description: drink['strDescription'],
          glass_type: drink['strGlass'],
          thumbnail: drink['strDrinkThumb'],
          portions: (
            {}.tap do |portions|
              15.times do |num|
                break if drink["strIngredient#{num + 1}"] == 'null'

                portions[drink["strIngredient#{num + 1}"]] = drink["strMeasure#{num + 1}"]
              end
            end
          )
        )
      end
    end
  end
end
