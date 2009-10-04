module StepsHelper
  
  def next_action
    if current_page? :action => 'materials'
	    [ "first step", { :action => "step", :id => '1' } ]
	  elsif controller.controller_name == 'comments'
	    [ 'home', { :controller => 'steps', :action => 'index' } ]
	  elsif current_page? :action => 'index' or current_page? :action => 'site_map'
      [ "materials list", { :action => "materials" } ]
	  elsif @img == Step.last || controller.action_name == 'all'
	    [ "comment", { :controller => "comments" } ]
	  elsif controller.action_name == 'step'
      [ "next", { :action => "step", :id => Step.next(params[:id]) } ]
    end
  end
  

  def prev_action
    if @img == Step.first
      [ "materials list", { :action => "materials" } ]
    elsif controller.action_name == 'step'
      [ "previous", { :action => "step", :id => Step.prev(params[:id]) } ]
    end
  end

  def link_to_prev
    text, url = prev_action
    link_to "&laquo; #{text}", url, :class => "left" if text
	end
	
	def link_to_next
	  text, url = next_action
	  link_to "#{text} &raquo;", url, :class => "right" if text
  end
  
  def link_tags
    n={}; p={}
    n[:text], n[:url] = next_action
    p[:text], p[:url] = prev_action
    buffer = ''
    buffer += "<link rel='index' href='#{url_for :action => 'index'}' title='home' />\n"
    buffer += "<link rel='contents' href='#{url_for :action => 'site_map'}' title='site map' />\n"
    buffer += "<link rel='next' href='#{url_for n[:url]}' title='#{n[:text]}' />\n" if n[:url]
    buffer += "<link rel='prefetch' href='#{Step.new(n[:url][:id]).href}' />\n" if n[:url] && n[:url][:action] == "step"
    buffer += "<link rel='prev' href='#{url_for p[:url]}' title='#{n[:text]}' />\n" if p[:url]
    return buffer
  end
end
