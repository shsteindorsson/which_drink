class AddIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.text :description
      t.text :instructions
      t.string :glass_type
      t.string :thumbnail
      t.jsonb :portions
    end

    create_table :ingredients do |t|
      t.string :name
      t.text :description
      t.boolean :alcohol
    end

    create_table :cocktail_ingredients, id: false do |t|
      t.string :portion
      t.belongs_to :cocktails
      t.belongs_to :ingredients
    end

    add_index :cocktails, :name
    add_index :ingredients, :name
    add_index :ingredients, :alcohol
  end
end
