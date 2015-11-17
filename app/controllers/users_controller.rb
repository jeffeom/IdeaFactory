class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email,
                                                :password, :password_confirmation)
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user_id
      redirect_to root_path, notice: "Account Successfully Created!"
    else
      render :new
    end
  end

  def update
    @user = User.find params[:id]
    user_params = params.require(:user).permit([:join])
    if @user.update(user_params)
      if user_params.has_key?(:join)
        redirect_to ideas_path, notice: "Idea Updated"
      else
        # redirect_to idea_path(@idea), notice: "Idea Updated!"
        redirect_to ideas_path, notice: "Idea Updated!"
      end
    else
      render :edit
    end
  end
end
