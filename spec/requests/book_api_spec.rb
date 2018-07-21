require "rails_helper"

describe 'Book API' do
  it 'returns all books' do
    Book.create(title: "Infinity War", author: "Thanos")
    Book.create(title: "Age of Ultron", author: "Ultron")
    Book.create(title: "Avengers", author: "Loki")

    get "/api/v1/books"

    content = JSON.parse(response.body)

    expect(content["book_count"]).to eq(3)
    expect(content["books"].length).to eq(3)
    expect(content["books"].first["title"]).to eq("Infinity War")
    expect(content["books"].first["author"]).to eq("Thanos")
  end

end