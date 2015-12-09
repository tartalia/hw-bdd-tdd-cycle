require "rails_helper"

RSpec.describe MoviesController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end

    it "order movies correctly by title" do
      movie1 = Movie.create!(title: "Star Wars", rating: "PG", director: "George Lucas", release_date: "1977-05-25")
      movie2 = Movie.create!(title: "Anaconda", rating: "PG", director: "George Lucas", release_date: "1977-05-25")
      get :index, {:sort => 'title'}
      expect(assigns(:title_header)).to eq('hilite')
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      Movie.create!(title: "Star Wars", rating: "PG", director: "George Lucas", release_date: "1977-05-25")
      get :show, :id => 1
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    it "successfully create a new movie" do
      post :create, movie: {:title => "Star Wars", :rating => "PG", :director => "George Lucas", :release_date => "1977-05-25"}
      expect(response).to redirect_to movies_path
    end
  end

  describe "GET #edit" do
    it "successfully edit a movie" do
      movie = Movie.create!(title: "Star Wars", rating: "PG", release_date: "1977-05-25")
      post :edit, :id => 1
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("edit")
    end
  end

  describe "POST #update" do
    it "successfully update a movie" do
      movie = Movie.create!(title: "Star Wars", rating: "PG", release_date: "1977-05-25")
      post :update, :id => 1, movie: {:title => "Star Wars", :rating => "PG", :director => "George Lucas", :release_date => "1977-05-25"}
      expect(response).to redirect_to movie_path(movie)
    end
  end

  describe "DELETE #destroy" do
    it "successfully destroy a movie" do
      Movie.create!(title: "Star Wars", rating: "PG", release_date: "1977-05-25")
      delete :destroy, :id => 1
      expect(response).to redirect_to movies_path
    end
  end

  describe "GET #related" do
    it "successfully get related movies" do
      movie = Movie.create!(title: "Star Wars", rating: "PG", director: "George Lucas", release_date: "1977-05-25")
      get :related, :id => movie.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("related")
    end

    it "do not find related movies where director is null" do
      movie = Movie.create!(title: "Star Wars", rating: "PG", release_date: "1977-05-25", director: "")
      get :related, :id => movie.id
      expect(response).to redirect_to movies_path
    end
  end
end
