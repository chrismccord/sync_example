class UsersController < ApplicationController

  def index
    @users = User.order('created_at ASC')

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        sync_new @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        sync @user, :update
        format.html { redirect_to [:edit, @user], notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    sync @user, :destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.js { head :no_content }
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
