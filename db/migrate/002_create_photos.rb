class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column 'comment_id', :integer
      
      t.column "content_type", :string
      t.column "filename", :string     
      t.column "size", :integer
      
      # used with thumbnails, always required
      t.column "parent_id",  :integer 
      t.column "thumbnail", :string
      
      # required for images only
      t.column "width", :integer  
      t.column "height", :integer
      
    end
  end

  def self.down
    drop_table :photos
  end
end
