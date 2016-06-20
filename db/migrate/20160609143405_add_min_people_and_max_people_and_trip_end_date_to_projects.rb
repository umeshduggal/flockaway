class AddMinPeopleAndMaxPeopleAndTripEndDateToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :min_people, :integer
  	add_column :projects, :max_people, :integer
  	add_column :projects, :trip_end_date, :datetime
  end
end
