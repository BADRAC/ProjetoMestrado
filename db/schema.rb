ActiveRecord::Schema.define(version: 20140514002322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "abstract"
    t.string   "url"
    t.integer  "edition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles_authors", id: false, force: true do |t|
    t.integer "article_id"
    t.integer "author_id"
  end

  create_table "articles_keywords", id: false, force: true do |t|
    t.integer "article_id"
    t.integer "keyword_id"
  end

  create_table "authors", force: true do |t|
    t.string   "fullname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "editions", force: true do |t|
    t.string   "e_name"
    t.date     "e_date"
    t.integer  "journal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journals", force: true do |t|
    t.string   "j_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", force: true do |t|
    t.string   "kw_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
