10_000.times do |i|
  Article.create(title: "Article ##{i}", description: 'A article.')
end
