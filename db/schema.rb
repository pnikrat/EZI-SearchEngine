# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171212185556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: :cascade do |t|
    t.string "description"
    t.string "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.text "stem"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tfidf_vector"
    t.float "cosine_similarity"
    t.text "stemcount_vector"
    t.string "klass"
    t.bigint "document_group_id"
    t.index ["cosine_similarity"], name: "index_documents_on_cosine_similarity"
    t.index ["document_group_id"], name: "index_documents_on_document_group_id"
    t.index ["title"], name: "index_documents_on_title"
  end

  create_table "groupings", force: :cascade do |t|
    t.integer "number_of_groups"
    t.float "minimum_similarity"
    t.boolean "similarity_stop_condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "query_expanding_modes", force: :cascade do |t|
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string "query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stem"
    t.text "tfidf_vector"
    t.bigint "search_id"
    t.index ["search_id"], name: "index_searches_on_search_id"
  end

  create_table "terms", force: :cascade do |t|
    t.string "full"
    t.string "stem"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "idf"
  end

  add_foreign_key "documents", "document_groups"
  add_foreign_key "searches", "searches"
end
