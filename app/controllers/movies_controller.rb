class MoviesController < ApplicationController
  def index
    DataService.new.delay.crawl_data
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
