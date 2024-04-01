class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      # attributes
      t.string :token
      t.integer :user_id, foreign_key: true, index: true

      t.timestamps
    end
  end
end
