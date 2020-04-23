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

ActiveRecord::Schema.define(version: 2020_04_23_032426) do

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

  create_table "content_texts", force: :cascade do |t|
    t.bigint "content_id", null: false
    t.text "excerpt"
    t.string "full_text_hash", null: false
    t.text "full_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_content_texts_on_content_id", unique: true
    t.index ["full_text_hash"], name: "index_content_texts_on_full_text_hash"
  end

  create_table "contents", force: :cascade do |t|
    t.bigint "content_source_id", null: false
    t.string "uuid", null: false
    t.string "content_type", null: false
    t.datetime "found_at", null: false
    t.datetime "published_at", null: false
    t.datetime "modified_at"
    t.text "image_url"
    t.string "title"
    t.string "display_text", null: false
    t.string "url_hash", null: false
    t.text "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_source_id"], name: "index_contents_on_content_source_id"
    t.index ["content_type"], name: "index_contents_on_content_type"
    t.index ["found_at"], name: "index_contents_on_found_at"
    t.index ["published_at"], name: "index_contents_on_published_at"
    t.index ["url_hash"], name: "index_contents_on_url_hash", unique: true
    t.index ["uuid"], name: "index_contents_on_uuid", unique: true
  end

  add_foreign_key "content_texts", "contents"
  add_foreign_key "contents", "content_sources"
end
