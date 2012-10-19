# app/controllers/movies_controller.rb  
class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by_id(params[:id])
    if @movie == nil then
      flash[:notice] = "La pelicula solicitada #{params[:id]} no existe."
      redirect_to movies_path
    end
  end

  # ORDEN ALFABETICO
  # Procedimiento 1: 
  # En movies_controller.rb descomentar @movies = Movie.all y comentar @movies = Movie.all.sort_by {|m| m.title} en def index
  # En index.html.haml descomentar '- @movies = @movies.sort_by {|m| m.title}'
  # Procedimiento 2: 
  # En movies_controller.rb comentar @movies = Movie.all y descomentar @movies = Movie.all.sort_by {|m| m.title} en def index
  # En index.html.haml comentar '- @movies = @movies.sort_by {|m| m.title}'

  def index
    #@movies = Movie.all
    @movies = Movie.all.sort_by {|m| m.title.downcase}

  end

  def new
    # default: render 'new' template
  end

  # in movies_controller.rb
  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movie_path(@movie)
  end


  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
