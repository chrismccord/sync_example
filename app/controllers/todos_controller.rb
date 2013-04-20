class TodosController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_project

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
        sync_new @todo, scope: @project
        sync_update @todo.project.reload

        format.html { redirect_to [@todo.project, @todo], notice: 'Todo was successfully created.' }
        format.js { render json: @todo, status: :created, location: [@todo.project, @todo] }
      else
        format.html { render action: "new" }
        format.js { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @todo = @project.todos.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(todo_params)
        sync_update [@todo, @project]
        format.html { redirect_to [@todo.project, @todo], notice: 'Todo was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render action: "edit" }
        format.js { render json: @todo.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @todo = @project.todos.find(params[:id])
    @todo.destroy

    sync_destroy @todo
    sync_update @todo.project.reload
    respond_to do |format|
      format.html { redirect_to project_path(@todo.project) }
      format.js { head :no_content }
    end
  end


  private

  def todo_params
    params.require(:todo).permit :title, :description, :complete
  end

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end

end
