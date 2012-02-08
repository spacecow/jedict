ActiveRecord::Schema.define(:version => 20120130104229) do

  create_table "definitions", :force => true do |t|
    t.string   "reading"
    t.integer  "glossary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "glossaries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meanings", :force => true do |t|
    t.string   "content"
    t.integer  "definition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
