class AddLoginTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :login_type, default: 'email', null: false
    end
  end
end