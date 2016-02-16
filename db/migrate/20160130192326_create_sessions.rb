class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :token
      t.string :string
      t.string :ip
      t.belongs_to :login

      t.timestamps null: false
    end
  end
end
