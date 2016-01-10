class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date, null: false
      t.string :user, null: false
      t.string :type_of, null: false
      t.string :message
      t.string :otheruser
      t.timestamps null: false
    end
  end
end
