class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.timestamps
      t.string     :auth_token
    end

    add_index :users, :auth_token, unique: true
  end
end
