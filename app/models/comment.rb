class Comment < ActiveRecord::Base
  has_one :photo
  
  attr_accessor :captcha
  
  validates_numericality_of :completed, :allow_nil => true, :message => 'the number of balls that you have made has to be a number'
  validates_length_of :author,
        :within => 2..25,
        :too_short => 'please put in your name',
        :too_long => 'your name can\'t be that long. if it really is, just use a nickname or something'
  validates_length_of :title,
        :within => 4..100,
        :too_short => 'please write a decent title',
        :too_long => 'you don\'t need that much text in your title'
  validates_length_of :body,
        :within => 5..1000,
        :too_short => 'if you are going to post a comment, at least write something',
        :too_long => 'whoa, are you trying to write a novel here? If you have that much to write, maybe you need to post two comments'
        
  validates_format_of :captcha, :with => /^(four|4)$/, :message => 'please answer the random question to prevent spam'
  
  # def photo_upload=(uploaded_file)
  #   @p = Photo.new({:uploaded_data => uploaded_file})
  # end
  # 
  # def after_create
  #   if @p
  #     update_attribute(:photo, @p)
  #     @p.save
  #   end
  # end
  # 
  def to_param
    id #created_at.to_formatted_s(:db).gsub(/ /,'-')
  end

end
