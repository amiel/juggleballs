class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :author, :string
      t.column :title, :string
      t.column :completed, :integer
      t.column :body, :text
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :comments
  end
end
