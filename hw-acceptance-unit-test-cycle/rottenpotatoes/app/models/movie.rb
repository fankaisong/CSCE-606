class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.similar_movies (movie_title)
    movie = Movie.where(title:movie_title).first
    movie_director = movie.director

    if movie_director.nil? or movie_director.blank?
    	return nil
    end
    Movie.where(director:movie_director).pluck(:title)

  end

end
