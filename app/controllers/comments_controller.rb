class CommentsController < ApplicationController
  layout 'plain'

  before_action :load_movie
  before_filter :authenticate, only: %i(new create destroy)

  def create
    @comment = @movie.comments.new(comment_params)
    if @comment.save
      @movie.update_attribute(:rating, (@movie.rating + @comment.rating)/@movie.comments.all.length)
      respond_to do |format|
        format.html { redirect_to @movie }
        format.js { render 'fail_create.js.erb' }
      end
    else
      render action: :new
    end
  end

  private

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:username, :body, :rating)
  end
end
