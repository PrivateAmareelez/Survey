class AddColumnActiveToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :active, :boolean
  end
end
