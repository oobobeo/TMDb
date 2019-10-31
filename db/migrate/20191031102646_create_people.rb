class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :department
      t.string :character
      t.string :job

      t.timestamps
    end
  end
end
