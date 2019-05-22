class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    #render json: @post
    aux =""
    tam = @post.uploads.length
    limit = tam -1
    for j in 0..limit

      if j < limit
        aux = aux+ @post.uploads_on_disk(j) + ","
      elsif j == limit
        aux = aux+ @post.uploads_on_disk(j)

      end
    end
    # vardeprueba= @post.uploads[0].filename.to_s
    #puts vardeprueba
    #puts  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    aux =""
    aux2 =""
    if @post.save

      tam = @post.uploads.length
      limit = tam -1
      for j in 0..limit

        if j < limit
         # @post.active_storage_object.blob.update(filename: "desired_filename.#{self.active_storage_object.filename.extension}")
         #@post.uno.blob.update(filename: 'aaa.png')
       aux = aux+ @post.uploads_on_disk(j) + ","
       aux2 = aux2 + @post.uploads[j].filename.to_s + ","
        elsif j == limit

         
        aux = aux+ @post.uploads_on_disk(j)
        aux2 = aux2 + @post.uploads[j].filename.to_s

        end
      end
      #puts  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      #puts aux

      #render json: output = {'path' => "#{aux}"}.to_json

      pruebaJ= @post.to_json
      pruebaH=JSON.parse(pruebaJ)

      pruebaH.delete("created_at")
      pruebaH.delete("updated_at")
      #hash2 = {'path' => "#{aux}"}
      pruebaH.store("path",aux)
      pruebaH.store("name",aux2)

      #pruebaJ.push({"path" => aux})

      render :json => pruebaH.to_json
      #render json: pruebaJ

    else
      render json: @post.errors, status: :unprocessable_entity
    end

  end


  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.permit(:name, :owner, :description, uploads: [] )
    end
end
