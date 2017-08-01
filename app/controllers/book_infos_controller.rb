class BookInfosController < ApplicationController
  before_action :set_book_info, only: [:show, :update, :destroy]

  # GET /book_infos
  def index
    @book_infos = BookInfo.all

    render json: @book_infos
  end

  # GET /book_infos/1
  def show
    render json: @book_info
  end

  # POST /book_infos
  def create
    @book_info = BookInfo.new(book_info_params)

    if @book_info.save
      render json: @book_info, status: :created, location: @book_info
    else
      render json: @book_info.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /book_infos/1
  def update
    if @book_info.update(book_info_params)
      render json: @book_info
    else
      render json: @book_info.errors, status: :unprocessable_entity
    end
  end

  # DELETE /book_infos/1
  def destroy
    @book_info.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_info
      @book_info = BookInfo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_info_params
      params.require(:book_info).permit(:name, :isbn, :cost)
    end
end
