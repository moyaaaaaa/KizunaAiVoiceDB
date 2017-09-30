class RenameFilenameColumnToVoices < ActiveRecord::Migration[5.1]
  def change
    rename_column :voices, :filename, :file
  end
end
