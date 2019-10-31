class CreateTVsPersonsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tvs, :people do |t|
      # t.index [:tv_id, :person_id]
      # t.index [:person_id, :tv_id]
    end
  end
end
