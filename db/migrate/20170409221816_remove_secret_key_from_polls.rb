class RemoveSecretKeyFromPolls < ActiveRecord::Migration[5.0]
  def change
    remove_column :polls, :SecretKey, :string
  end
end
