# frozen_string_literal: true

namespace :ingredients do
  desc 'remove empty fields from portions'
  task squish_description: :environment do
    Ingredient.all.each do |ingredient|
      puts "### Checking #{ingredient.name} ..."
      desc_clean = ingredient.description.squish
      ingredient.update!(description: desc_clean) if ingredient.description != desc_clean
    end
  end
end
