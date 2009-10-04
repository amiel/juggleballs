require 'RMagick'

# class methods and constants
class Step
  include Magick

  ABSOLUTE_DIR = "#{RAILS_ROOT}/public/images/steps"
  RELATIVE_DIR = "steps"
  WEB_DIR = "/images/#{RELATIVE_DIR}"
  
  # for file matching, only to include numbers
  IS_STEP = 'step_[0-9][0-9][0-9_.]*jpg' # include step_01 but not step_04b
  
  # for regex matching, this is also a broader pattern match than IS_STEP
  IS_VALID_STEP_FILE = 'step_([0-9a-z_]+).jpg'

  @@img_list = nil

  def self.in_img_dir
    Dir.chdir(ABSOLUTE_DIR) do
      yield
    end
  end

  def self.each
    img_list.each do |file|
      yield Step.new(file)
    end
  end

  def self.last
    Step.new(img_list.last)
  end

  def self.first
    Step.new(img_list.first)
  end
  
  def self.next(step)
    a = img_list
    Step.new(a[a.index(Step.new(step).file)+1]).to_param
  end
  
  def self.prev(step)
    a = img_list
    Step.new(a[a.index(Step.new(step).file)-1]).to_param
  end
  
  def self.img_list
    return @@img_list if @@img_list
    Dir.chdir(File.join(ABSOLUTE_DIR,"orig")) do
      @@img_list = Dir[IS_STEP].sort
    end
    return @@img_list
  end
end


# instance methods
# instance_variables:
# => @file - the basename of the image file
# => @step - the "step"
#     note: even though StepImage::first/last etc only accept numbers in the "step"
#           a step can have letters if they are meant to be out of the list.
# => @width
# => @height
class Step
  def fix_step(s)
    (s.gsub("_",".").to_f < 10 && !(s[0,1] == "0")) ? "0#{s}" : s.to_s
  end
  
  # reader for @step
  def step
    @step
  end
  
  def to_i
    (@step[0,1] == "0") ? @step[1..-1].gsub("_",".") : @step
  end
  
  def to_param
    (@step[0,1] == "0") ? @step[1..-1] : @step
  end
  
  # pre:
  # arg must be one of 
  # => a String with the filename (which is a valid step file, ie "step_04.jpg")
  # => or a step number, see note in instance_variable above
  def initialize(arg)
    if arg =~ Regexp.new(IS_VALID_STEP_FILE)
      @step = Regexp.new(IS_VALID_STEP_FILE).match(arg)[1]
      @file = arg
    else
      @step = fix_step(arg)
      @file = "step_#{@step}.jpg"
    end
  end
  

  attr_reader :file

  def ==(other)
    @file == other.file
  end

  def has_image?
    Step::in_img_dir { Dir[@file][0] }
  end

  def set_sizes(width, height)
    @width = width
    @height = height
  end


  def tag_opts(options = {})
    image_setup
    
    default_options = { :id => "step_#{@step}_pic", :size => "#{@width}x#{@height}", :alt => "Image for step #{to_i}. We appologize to anyone who cannot see these images, we may have more descriptive text here in the future." }
    options = default_options.merge options
  end

  def href
    "#{WEB_DIR}/#{@file}"
  end

  def image_setup
    if self.has_image?
      calculate_image_size
    else
      resize_image_to_fit 750, 475
    end
  end

  private
  def calculate_image_size
    Step::in_img_dir do
      img = Magick::ImageList.new
      img.ping(@file)
      set_sizes img.columns, img.rows
    end
  end

  # 
  # THIS IS REALLY SLOW
  # NOTE: no need to call calculate_image_size becuase 
  # resize_image_to_fit sets @width and @height
  private
  def resize_image_to_fit(width, height)
    Step::in_img_dir do
      img = Magick::ImageList.new("orig/#{@file}")

      # I supposed this was a good way to check if the image loaded
      # unless img.empty? might make more sense

      if img.respond_to? :resize_to_fit!
        img.resize_to_fit!(width, height)
        set_sizes img.columns, img.rows
        img.write @file
      else
        raise "Could not resize image #{@file}"
      end
    end
  end


end
