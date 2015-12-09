Given(/^the following movies exist:$/) do |table|
  table.hashes.each do |row|
    m = Movie.new(:title => row[:title], :rating => row[:rating], :director => row[:director], :release_date => row[:release_date])
    m.save
  end
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |movie, director|
  path_to('the details page for "' + movie + '"')
  element = find("#director")
  expect(element.text).to match(/Director: #{director}/)
end
