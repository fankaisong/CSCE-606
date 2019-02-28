Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'search_movies/:id' => 'movies#search_movies', as: :find_similar_movies
end


    # when /^the Similar Movies page for "([^"]*)"$/
    #     search_by_director_path(Movie.find_by_title($1))
