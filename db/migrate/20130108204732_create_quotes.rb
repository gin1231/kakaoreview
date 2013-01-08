class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string   "title"
      t.text    "content"

      t.integer  "chat_id"
      t.integer  "user_id"

      t.timestamps
    end
  end
end
