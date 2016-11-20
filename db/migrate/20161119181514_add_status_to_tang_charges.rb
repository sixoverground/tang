class AddStatusToTangCharges < ActiveRecord::Migration
  def change
    add_column :tang_charges, :status, :string
  end
end
