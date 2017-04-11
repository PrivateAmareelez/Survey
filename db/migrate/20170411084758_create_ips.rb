class CreateIps < ActiveRecord::Migration[5.0]
  def change
    create_table :ips do |t|
      t.references :reply, foreign_key: true

      t.timestamps
    end
  end
end
