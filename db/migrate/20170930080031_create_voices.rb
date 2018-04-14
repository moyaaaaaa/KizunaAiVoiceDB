class CreateVoices < ActiveRecord::Migration[5.1]
  def change
    create_table :voices, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
      t.string :filename
      t.string :line

      t.timestamps
    end
    add_index :voices, :filename, unique: true
  end
end
