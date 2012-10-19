class StepsController < ApplicationController

  def index
    @title = "Juggling Bean Bag Pattern -- Step by step instructions to make pretty juggling balls"
  end

  def step
    @step = (params[:id]) ? params[:id] : 1
    @img = Step.new(@step)
    @title = "Step: #{@img.to_i} -- Juggle Ball Pattern"
  end

  def all
    @title = "All steps -- Juggle Ball Pattern"
    @imgs = []
    Step.each do |s|
      @imgs.push s
    end
  end

  def materials
    @title = "Materials List -- Juggle Ball Pattern"
  end

  def site_map
    @title = "Site Map -- Juggle Ball Pattern"
  end

  def links # I know its not really a step, but it still has nice pretty url
    @title = "Links -- Juggle Ball Pattern"
    @links = {
      'http://www.twjc.co.uk/doc007.html' => 'How to make easier and cheaper balls.',
      'http://www.jugglingisasnap.org'    => 'Learn to Juggle at Juggling Is A Snap!',
      'http://www.jugglingpoet.com/crju/' => 'More beanbags, balloon balls, and nice juggling tutorials.',

    }
  end
end
