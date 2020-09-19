require 'rest-client'
require 'json'

module Drinkfinder
  def self.find(options)
    unless options.nil?
      ingredients = options.split(',')
      ingredients.each do |ingredient|
        response = RestClient.get(
          "https://www.thecocktaildb.com/api/json/v1/1/filter.php",
          {
            params: {
              i: ingredient
            }
          }
        )
    
      if response.body == ""
        'error'
      else
        results = JSON.parse(response)
        results['drinks']
      end
    end
  end
end

