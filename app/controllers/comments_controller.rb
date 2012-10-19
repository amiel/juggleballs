class CommentsController < ApplicationController
  helper :steps


  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ],
         :redirect_to => { :action => :index }

  def index
    @title = "Comments -- Juggle Ball Pattern"

    @comments = Comment.all :order => 'created_at DESC'

    # for form, note this is @comment, not @comments
    @comment ||= Comment.new
  end


  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash.now[:notice] = 'Thank you for your comment.'
      redirect_to :action => 'index'
    else
      flash.now[:notice] = 'There was an error posting your comment.'
      index
      render :action => 'index'
    end
  end

  def photo_upload
    render :partial => 'photo_upload'
  end

  def show
    @comment = Comment.find(params[:id])
  end

end
