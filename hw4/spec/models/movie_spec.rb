require "rails_helper"

RSpec.describe Movie, :type => :model do
  it "have director field" do
    Movie.create!(title: "Star Wars", rating: "PG", director: "George Lucas", release_date: "1977-05-25")
    expect(Movie.where(title: "Star Wars").first.director).to eq("George Lucas")
  end
end
