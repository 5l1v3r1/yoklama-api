class CreateInspectionImages < ActiveRecord::Migration[5.2]
  def change
    create_table :inspection_images do |t|

      t.timestamps
    end
  end
end
