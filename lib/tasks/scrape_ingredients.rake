# frozen_string_literal: true

require 'faraday'
require 'json'

INGREDIENTS_URL = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

namespace :ingredients do
  desc 'scrape ingredients'
  task scrape_ingredients: :environment do
    ActiveRecord::Base.transaction do
      ingredients_response = Faraday.new(INGREDIENTS_URL).get
      ingredients_list     = JSON.parse(ingredients_response.body)['drinks'].map(&:values).inject(:+)
      ingredients_list.each do |ingredient|
        raise "NON-ASCII ingredient: #{ingredient}" unless URI.encode_www_form_component(ingredient).ascii_only?

        puts "***Ingredient: #{ingredient}"
        url = URI.parse(
          "https://www.thecocktaildb.com/api/json/v1/1/search.php?i=#{URI.encode_www_form_component(ingredient)}"
        )
        req = Faraday.new(url).get
        response = JSON.parse(req.body)['ingredients'].first
        Ingredient.create!(
          name: response['strIngredient'],
          description: response['strDescription'],
          alcohol: response['strAlcohol']&.downcase == 'yes'
        )
      end
    end
  end
end
