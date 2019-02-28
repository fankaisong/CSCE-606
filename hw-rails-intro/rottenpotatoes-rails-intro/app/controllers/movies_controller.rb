class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all

    @all_ratings = []#stores all unique ratings
    #push each unique rating into 'all_ratings'
    Movie.select(:rating).uniq.each {|r| @all_ratings.push(r.rating)}

    if params[:ratings]#if refresh is clicked
        #find rating in database where the rating==checked box        
        session[:ratings] = params[:ratings].keys#remember the checked box data
    end
    @movies = Movie.where(:rating=>session[:ratings]) #find all movies that have the same rating



    if params[:sort] == nil#when params[:sort] is not available
      @sort = session[:sort]#save the session into '@sort'

    else #if sort is clicked "Movie Title" or "release data"
      @sort = params[:sort]
      session[:sort] = params[:sort]#remember the sort and save into the session      
    end

    @movies = @movies.order(@sort)#sort the movies based on '@sort'

    

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
