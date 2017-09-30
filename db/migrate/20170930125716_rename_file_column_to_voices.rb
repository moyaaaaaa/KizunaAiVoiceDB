class RenameFileColumnToVoices < ActiveRecord::Migration[5.1]
  def change
    rename_column :voices, :file, :voice_file
  end
end
