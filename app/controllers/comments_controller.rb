class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(comment_params)
    @comment.book_id = @book.id
    if @comment.save
      render :comment
      #redirect_to book_path(@book)
    else
      @user = @book.user
      @newbook = Book.new
      render "books/show"
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.find_by(book_id: @book.id)
    @comment.destroy
    render :comment
    #redirect_to book_path(@book)
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
