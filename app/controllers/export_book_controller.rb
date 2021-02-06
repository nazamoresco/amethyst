class ExportBookController < ApplicationController
  before_action :set_book, only: [:create]

  # POST /books
  # POST /books.json
  def create
    render pdf: @book.title
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:format])
  end
end
