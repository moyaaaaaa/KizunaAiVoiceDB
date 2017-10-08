class AddColumnToVoice < ActiveRecord::Migration[5.1]
  def change
    add_column :voices, :start, :float, after: :url
    add_column :voices, :during, :float, after: :start
  end
end
