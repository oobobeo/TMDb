class CreateMovieRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_roles do |t|
      t.integer :person_id
      t.integer :movie_id
      t.string :department
      t.string :character
      t.string :job

      t.timestamps
    end
  end
end
