class AddValidatedToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :validated, :boolean, default: nil
  end
end
