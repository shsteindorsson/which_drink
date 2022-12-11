# frozen_string_literal: true

namespace :cocktails do
  desc 'remove empty fields from portions'
  task fix_portions: :environment do
    Cocktail.all.each do |cocktail|
      cocktail.portions.delete('')
      cocktail.save!
    end
  end
end
