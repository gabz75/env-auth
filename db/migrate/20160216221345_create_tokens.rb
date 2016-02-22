class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :token
      t.string :string
      t.string :ip
      t.belongs_to :account

      t.timestamps null: false
    end
  end
end
