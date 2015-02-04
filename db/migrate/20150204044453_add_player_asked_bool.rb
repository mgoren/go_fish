class AddPlayerAskedBool < ActiveRecord::Migration
  def change
    add_column :players, :fail_ask, :boolean, default: false
  end
end
