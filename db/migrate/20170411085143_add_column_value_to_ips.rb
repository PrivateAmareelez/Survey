class AddColumnValueToIps < ActiveRecord::Migration[5.0]
  def change
    add_column :ips, :value, :string
  end
end
