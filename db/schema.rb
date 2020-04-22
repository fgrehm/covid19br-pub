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

ActiveRecord::Schema.define(version: 2020_04_22_221908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "content_sources", force: :cascade do |t|
    t.string "guid", null: false
    t.string "name", null: false
    t.string "region", null: false
    t.string "state", null: false
    t.string "twitter"
    t.text "site"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guid"], name: "index_content_sources_on_guid", unique: true
    t.index ["name"], name: "index_content_sources_on_name", unique: true
    t.index ["region"], name: "index_content_sources_on_region"
    t.index ["state"], name: "index_content_sources_on_state"
  end

end
