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



    describe 'edit' do
        it 'edit a movie' do
            Movie.create!(:title => "what what", :rating => "PG", :director => "who cares", :release_date => "2019-01-1")
            mov = Movie.find_by_title("what what")
            get :edit, {:id => mov}
            expect(assigns(:movie)).to eq(mov)
        end
    end


    describe 'create' do
        it 'create a movie' do
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

        it 'check director for  Stars Wars' do
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
            expect(flash[:notice]).to eq("\"#{mov.title}\" does not have a director!")
            expect(response).to redirect_to(root_url)
        end
    end

end