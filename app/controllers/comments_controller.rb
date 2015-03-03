class CommentsController < ApplicationController
  helper :steps

  def index
    @title = "Comments -- Juggle Ball Pattern"
  end

  def test
    @comments = Comment.all
    render layout: false
  end


end
