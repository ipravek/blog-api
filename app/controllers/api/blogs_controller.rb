class Api::BlogsController < ApiController

  def index
    blogs = Blog.active.map(&:to_objects)
    return render json: {data: blogs}
  end

  def create
    @blog = Blog.new(
      user: @current_user,
      article: params[:article],
      description: params[:description],
      title: params[:title]
      )

    if @blog.save
      return render json: {message: 'Blog created', data: @blog.to_objects}
    else
      return render json: {message: 'some thing went wrong'}, status: 400
    end
  end

end
