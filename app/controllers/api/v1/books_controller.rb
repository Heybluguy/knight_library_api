class Api::V1::BooksController < ApplicationController

  def index
    books = Book.all
    render json: {
      book_count: books.count,
      books: books
    }
  end
end