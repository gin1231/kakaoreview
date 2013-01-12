class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer "type"
      t.string  "username"
      t.text    "content"
      t.datetime  "created_at"

      t.integer  "chat_id"


    end
  end
end
