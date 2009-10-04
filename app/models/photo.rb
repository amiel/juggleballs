class Photo < ActiveRecord::Base
  belongs_to :comment
  acts_as_attachment :storage => :file_system, :thumbnails => { :normal => '300>', :thumb => 'x70' }
  validates_as_attachment
end
