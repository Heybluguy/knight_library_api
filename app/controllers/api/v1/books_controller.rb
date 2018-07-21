class Api::V1::BooksController < ApplicationController

  def index
    books = Book.all
    render json: {
      book_count: books.count,
      books: books
    }
  end

  def show
    book = Book.find(params[:id])
    render status: 200, json: book
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      render status: 202, json: {
        messages: "Succesfully updated book #{book.id} to #{book.title}"
      }
    else
      render status: 400, json: {
        messages: "Something went wrong"
      }
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.delete
      render status: 200, json: {
        messages: "Successfully deleted book"
      }
    else
      render status: 400, json: {
        messages: "Something went wrong"
      }
    end
  end

    private
      def book_params
        params.require(:book).permit(:title, :author)
      end

end