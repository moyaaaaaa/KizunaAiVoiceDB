class AddUploaderNameToVoice < ActiveRecord::Migration[5.1]
  def change
    add_column :voices, :uploader_name, :string, after: :during
  end
end
