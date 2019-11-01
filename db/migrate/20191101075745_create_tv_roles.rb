class CreateTvRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :tv_roles do |t|
      t.integer :person_id
      t.integer :tv_id
      t.string :department
      t.string :character
      t.string :job

      t.timestamps
    end
  end
end
