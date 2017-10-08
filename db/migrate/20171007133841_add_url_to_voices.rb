class AddUrlToVoices < ActiveRecord::Migration[5.1]
  def change
    add_column :voices, :url, :string, after: :line
  end
end
