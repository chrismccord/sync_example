class CommentsController < ApplicationController

  before_action :find_resources

  def index
    @comments = @todo.comments

    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def show
    @comment = @todo.comments.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  def new
    @comment = @todo.comments.build

    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @todo.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        sync_new @comment, scope: @todo
        @comment = nil
        sync_update [@todo, @todo.project]
        format.html { redirect_to [@project, @todo], notice: 'Comment was successfully created.' }
        format.js { head :no_content }
      else
        sync_update @todo
        format.html { render action: "new" }
        format.js { head :no_content }
      end
    end
  end

  def update
    @comment = @todo.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to [@project, @todo], notice: 'Comment was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @todo.comments.find(params[:id])
    @comment.destroy
    sync_destroy @comment, scope: @comment.todo
    sync_update @todo.project
    respond_to do |format|
      format.html { redirect_to [@project, @todo] }
      format.js { head :no_content }
    end
  end 


  private

  def comment_params
    params.require(:comment).permit :message
  end

  def find_resources
    @project = current_user.projects.find(params[:project_id])
    @todo = @project.todos.find(params[:todo_id])
  end
end
