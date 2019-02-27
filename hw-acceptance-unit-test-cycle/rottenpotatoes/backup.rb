    # @similar_movies = Movie.similar_movies(params[:title])
    # if @similar_movies.nil?
    #   flash[:notice] = "\"#{params[:title]}\" does not have a director!"
    #   redirect_to root_url
    # end
    # @movie = Movie.where(:title=> params[:title]).first




      # def self.similar_movies (movie_title)
  #   movie = Movie.where(title:movie_title).first
  #   movie_director = movie.director

  #   if movie_director.nil? or movie_director.blank?
  #   	return nil
  #   end
  #   Movie.where(director:movie_director).pluck(:title)

  # end