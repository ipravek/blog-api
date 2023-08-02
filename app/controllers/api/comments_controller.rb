class Api::CommentsController < ApiController

  def index
    blog = Blog.find params[:blog_id]
    return render json: {data: blog.comments.map(&:to_objects)}
  end


  def create
    blog = Blog.find params[:blog_id]
    comment = Comment.new user: @current_user, blog: blog, comment: params[:comment] #, parent_id: params[:parent_id]

    if comment.save!
      return render json: comment
    else
      return render json: {message: 'something went wrong'}, status: 400
    end
  end

end
