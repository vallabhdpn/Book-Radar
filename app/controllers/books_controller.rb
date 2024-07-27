class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /books or /books.json
  def index
    # if params[:query].present?
    #   @books = Book.where('Book_name LIKE ? OR Author LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    # else
      @books = Book.all
    # end
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = current_user.books.build
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = current_user.books.build(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    if @book.user == current_user
      @book.destroy
      respond_to do |format|
        # format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        # format.html { redirect_to books_url, alert: "You are not authorized to delete this book." }
        format.json { head :forbidden }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def correct_user
      redirect_to books_path, notice: "Not authorized to Delete this book" if @book.user != current_user
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:Book_name, :Author, :Owner, :Contact, :Location, :Availability)
    end
end
