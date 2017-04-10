class CreateSecretCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :secret_codes do |t|
      t.string :value
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
