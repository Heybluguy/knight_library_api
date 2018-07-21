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

  it 'returns a single book' do
    book_1 = Book.create(title: "Infinity War", author: "Thanos")
    book_2 = Book.create(title: "Age of Ultron", author: "Ultron")
    book_3 = Book.create(title: "Avengers", author: "Loki")

    get "/api/v1/books/#{book_2.id}"

    content = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(content["title"]).to eq("Age of Ultron")
    expect(content["author"]).to eq("Ultron")
  end

  it 'updates a single book' do
    book_1 = Book.create(title: "Infinity War", author: "Thanos")
    book_2 = Book.create(title: "Age of Ultron", author: "Ultron")
    book_3 = Book.create(title: "Avengers", author: "Loki")

    put "/api/v1/books/#{book_2.id}", params: {book: {title: 'Civil War'}}

    content = JSON.parse(response.body)
    updated_book_2 = Book.find(book_2.id)

    expect(response.status).to eq(202)
    expect(content["messages"]).to eq("Succesfully updated book #{book_2.id} to Civil War")
    expect(updated_book_2.title).to eq("Civil War")
  end

  it "deletes a book" do
    book_1 = Book.create(title: "Infinity War", author: "Thanos")
    book_2 = Book.create(title: "Age of Ultron", author: "Ultron")
    book_3 = Book.create(title: "Avengers", author: "Loki")

    expect(Book.count).to eq(3)
    delete "/api/v1/books/#{book_2.id}"

    content = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(content["messages"]).to eq("Successfully deleted book")
    expect(Book.count).to eq(2)
  end

end