class MoviesController < ApplicationController
  def index
    DataService.new.delay.crawl_data
    if params[:q]
      @movies = Movie.search(params[:q])
    else
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
