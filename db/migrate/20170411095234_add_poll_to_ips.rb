class AddPollToIps < ActiveRecord::Migration[5.0]
  def change
    add_reference :ips, :poll, foreign_key: true
  end
end
