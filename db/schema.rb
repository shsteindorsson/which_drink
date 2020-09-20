# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_19_214817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cocktails", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.text "description"
    t.text "instructions"
    t.string "glass_type"
    t.string "thumbnail"
    t.jsonb "portions"
  end

  create_table "cocktails_ingredients", id: false, force: :cascade do |t|
    t.bigint "cocktails_id"
    t.bigint "ingredients_id"
    t.index ["cocktails_id"], name: "index_cocktails_ingredients_on_cocktails_id"
    t.index ["ingredients_id"], name: "index_cocktails_ingredients_on_ingredients_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "alchohol"
  end

end
