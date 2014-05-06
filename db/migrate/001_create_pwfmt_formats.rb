class CreatePwfmtFormats < ActiveRecord::Migration
  def change
    create_table :pwfmt_formats do |t|
      t.integer :target_id, null: false
      t.string :field, null: false
      t.string :format, null: false

      t.timestamps
    end
    add_index :pwfmt_formats, [:target_id, :field], unique: true, name: 'pwfmt_formats_uniq_idx'
  end
end
