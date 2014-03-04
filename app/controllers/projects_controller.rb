class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  etag { current_user }
  etag { flash }

  def index
    @projects = current_user.projects

    if stale? @projects
      respond_to do |format|
        format.html # index.html.erb
        format.js { render json: @projects }
      end
    end
  end

  def show
    @project = current_user.projects.find(params[:id])

    if stale? @project
      respond_to do |format|
        format.html # show.html.erb
        format.js { render json: @project }
      end
    end
  end

  def new
    @project = current_user.projects.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { render json: @project }
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
    fresh_when @project
  end

  def create
    @project = current_user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        sync_new @project

        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.js { redirect_via_turbolinks_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render action: "new" }
        format.js { render action: "new" }
      end
    end
  end

  def update
    @project = current_user.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(project_params)
        sync @project, :update
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.js { redirect_via_turbolinks_to @project, notice: 'Project was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.js { render action: "edit" }
      end
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    sync_destroy @project

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.js { head :no_content }
    end
  end


  private

  def project_params
    params.require(:project).permit :name, :user_id
  end
end
