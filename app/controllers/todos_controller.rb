class TodosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_project

  enable_sync

  def index
    @todos = @project.todos

    respond_to do |format|
      format.html # index.html.erb
      format.js { render json: @todos }
    end
  end

  def show
    @todo = @project.todos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render json: @todo }
    end
  end

  def new
    @todo = @project.todos.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { render json: @todo }
    end
  end

  def edit
    @todo = @project.todos.find(params[:id])
  end

  def create
    @todo = @project.todos.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to [@todo.project, @todo], notice: 'Todo was successfully created.' }
        format.js { head :no_content }
      else
        format.html { render action: "new" }
        format.js { render "errors" }
      end
    end
  end

  def update
    @todo = @project.todos.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(todo_params)
        format.html { redirect_to [@todo.project, @todo], notice: 'Todo was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render action: "edit" }
        format.js { render "errors" }
      end
    end

  end

  def destroy
    @todo = @project.todos.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to project_path(@todo.project) }
      format.js { head :no_content }
    end
  end


  private

  def todo_params
    params.require(:todo).permit :title, :description, :complete, :user_id
  end

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end

end
