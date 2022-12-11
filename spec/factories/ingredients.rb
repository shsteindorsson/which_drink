# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    name { 'Vodka' }
    alcohol { true }
  end
end
