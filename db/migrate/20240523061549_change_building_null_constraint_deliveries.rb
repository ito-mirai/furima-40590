class ChangeBuildingNullConstraintDeliveries < ActiveRecord::Migration[7.0]
  def change
    change_column_null :deliveries, :building, true
  end
end
