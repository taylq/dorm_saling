class AddDeviseToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      ## Database authenticatable
      ## Recoverable
      change_column :users, :position, :integer, null: false, default: "2"
      change_column :users, :area_id, :integer, null: false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      add_column :users, :encrypted_password, :string, null: false, default: ""
      add_column :products, :user_id, :integer
      remove_column :users, :password, :string
      remove_column :products, :seller_id, :integer
      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
