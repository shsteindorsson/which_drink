# frozen_string_literal: true

FactoryBot.define do
  factory :cocktail do
    name { 'White Russian' }
    instructions do
      'Pour vodka and coffee liqueur over ice cubes in an old-fashioned glass. Fill with light cream and serve.'
    end
    portions do
      Hash['Vodka' => '1 part',
           'Light cream' => '1 part',
           'Coffee liqueur' => '1 part'].to_json
    end
  end
end
