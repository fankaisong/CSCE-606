require 'rails_helper'


RSpec.describe MoviesController, type: :controller do

    describe 'show' do

      it "should create a movie and check" do 
          Movie.create(title: 'HaHa', rating: 'PG', director: 'Mike', release_date: Date.new(2019,1,1))
          mov = Movie.find_by_title("HaHa")
          get :show, {:id=> mov}         
          expect(assigns(:movie)).to eq(mov)
        end
    end

    describe 'new' do
        it 'renders to the "new" template' do
            get :new
            expect(response).to render_template('new')
        end
    end

    describe 'update' do
        before :each do
        Movie.create(title: 'HaHa', rating: 'PG', director: 'Mike', release_date: Date.new(2019,1,1))
        end

        it 'updates the movie' do
            changed = {:title=> "HaHa=>LOL"}
            mov = Movie.find_by_title("HaHa")
            post :update, :id=> mov, :movie=>changed
            expect(flash[:notice]).to eq("#{changed[:title]} was successfully updated.")
            expect(response).to redirect_to(movie_path)
            expect(Movie.find(mov).title).to eq('HaHa=>LOL')
        end
    end

    describe 'edit' do
        it 'edits a movie' do
            Movie.create!(:title => "what what", :rating => "PG", :director => "who cares", :release_date => "2019-01-1")
            mov = Movie.find_by_title("what what")
            get :edit, {:id => mov}
            expect(assigns(:movie)).to eq(mov)
        end
    end


    describe 'create' do
        it 'creates a movie' do
            post :create, movie: {
                        title: "what what", 
                        rating: "PG", 
                        director: "who cares", 
                        release_date: "2019-12-30" }
            mov = Movie.find_by_title("what what")
            expect(assigns(:movie)).to eq(mov)
        end
        it 'flashes a creation notice' do
            post :create, movie: {
                        title: "what what", 
                        rating: "PG", 
                        director: "who cares", 
                        release_date: "2019-12-30" }
            title = Movie.find_by_title("what what").title
            expect(flash[:notice]).to eq("#{title} was successfully created.")
        end
        it 'redirects to the index' do
            post :create, movie: {
                        title: "what what", 
                        rating: "PG", 
                        director: "who cares", 
                        release_date: "2019-12-30" }
            expect(response).to redirect_to(movies_path)
        end
    end


    describe 'similar movies' do
        before :each do
            Movie.create!(:title => "Star Wars", :rating => "PG", :director => "George Lucas", :release_date => "1977-05-25")
            Movie.create!(:title => "Blade Runner ", :rating => "PG", :director => "Ridley Scott", :release_date => "1982-06-25")
            Movie.create!(:title => "Alien", :rating => "R", :director => "", :release_date => "1979-05-25")
            Movie.create!(:title => "THX-1138", :rating => "R", :director => "George Lucas", :release_date => "1971-03-11")
        end

        it 'checks director for  Stars Wars' do
            mov = Movie.find_by_title("Star Wars")
            get :search_movies, {:id => mov}
            expect(assigns(:movies)).to eq(Movie.where(director: "George Lucas"))
        end
        it 'renders to similar movies template' do
            mov = Movie.find_by_title("Star Wars")
            get :search_movies, {:id => mov}
            expect(response).to render_template("search_movies")
        end
        it 'redirects to the index when a director is not present' do
            mov = Movie.find_by_title("Alien")
            get :search_movies, {:id => mov}
            expect(flash[:notice]).to eq("\'#{mov.title}\' has no director info")
            expect(response).to redirect_to(root_url)
        end
    end

    describe "delete" do
        before :each do
            Movie.create!(:title => "what what", :rating => "PG", :director => "who cares", :release_date => "2019-01-1")
            @total_movies = Movie.all.count
        end

      it "Should destroy a movie" do
        
        mov = Movie.find_by_title("what what")
        get :destroy, :id=> mov

        after_deleted = Movie.all.count
        expect(flash[:notice]).to eq("Movie '#{mov.title}' deleted.")
        expect(response).to redirect_to(movies_path)
        expect(@total_movies-1).to eq(after_deleted)
      end

    end


    describe "sort" do
        before :each do
            Movie.create!(:title => "Star Wars", :rating => "PG", :director => "George Lucas", :release_date => "1977-05-25")
            Movie.create!(:title => "Blade Runner ", :rating => "PG", :director => "Ridley Scott", :release_date => "1982-06-25")
            Movie.create!(:title => "Alien", :rating => "R", :director => "", :release_date => "1979-05-25")
            Movie.create!(:title => "THX-1138", :rating => "R", :director => "George Lucas", :release_date => "1971-03-11")
        end

      it "sorts based on title" do
        get :index, :sort=> 'title'
      end

      it "sorts based on date" do
        get :index, :sort=> 'release_date'
      end

      it "shows all movies without the sort" do
        get :index
      end

    end
end



