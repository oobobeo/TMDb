class CreateTvs < ActiveRecord::Migration[6.0]
  def change
    create_table :tvs do |t|
      t.string :name

      t.timestamps
    end
  end
end
