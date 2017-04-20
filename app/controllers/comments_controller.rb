class CommentsController < ApplicationController
  layout 'plain'

  before_action :load_movie
  before_filter :authenticate, only: %i(new create destroy)

  def create
    @comment = @movie.comments.new(comment_params)
    if @comment.save
      @movie.update_attribute(:rating, update_movie_rating(@movie))
      respond_to do |format|
        format.html { redirect_to @movie }
        format.js
      end
    else
      respond_to do |format|
        format.html { render action: :new }
        format.js { render 'fail_create.js.erb' }
      end
    end
  end

  def destroy
    @comment = @movie.comments.find(params[:id])
    @comment.destroy
    @movie.update_attribute(:rating, update_movie_rating(@movie))
    respond_to do |format|
      format.html { redirect_to @movie }
      format.js
    end
  end

  private

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end

  def update_movie_rating(mv)
    rating = 0
    unless mv.comments.empty?
      mv.comments.each { |rt| rating += rt.rating }
      rating /= mv.comments.length
    end
    rating
  end

  def comment_params
    params.require(:comment).permit(:username, :body, :rating)
  end
end
