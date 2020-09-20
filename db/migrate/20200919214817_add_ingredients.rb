class AddIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.string :category
      t.text :description
      t.text :instructions
      t.string :glass_type
      t.string :thumbnail
      t.jsonb :portions
    end

    create_table :ingredients do |t|
      t.string :name
      t.text :description
      t.boolean :alchohol
    end

    create_table :cocktails_ingredients, id: false do |t|
      t.belongs_to :cocktails
      t.belongs_to :ingredients
    end
  end
end
