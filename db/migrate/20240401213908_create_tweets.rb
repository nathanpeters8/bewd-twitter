class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|

      # attributes
      t.string :message
      t.integer :user_id, foreign_key: true, index: true

      t.timestamps
    end
  end
end
