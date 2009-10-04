module CommentsHelper

  JOINS = [ ' and ', '. Also, ', ' and ' ]

  # create a paragraph with all the errors.
  def error_messages(my_super_model)
    errors = my_super_model.errors.collect { |field, error| error }
    return '' if errors.empty?
    
    buffer = ''
    errors.each_with_index do |s, i|
      
      buffer << (i == 0 ? s.humanize : s) + JOINS[ (i<JOINS.length) ? i : rand(JOINS.length) ] unless s == errors.last
    end
    buffer << errors.last + '.'
    content_tag(:div, buffer, :class => 'errors')
  end
end