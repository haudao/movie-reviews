class MoviesController < ApplicationController
  # before_filter :prepare_data, only: :index

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
