class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    user = User.find_by(id: session[:showing_user_id])
    if current_user?(user) || current_user.admin?
      @micropost = user.microposts.build(micropost_params)
    else 
      @micropost = current_user.microposts.build(micropost_params)
    end
    if @micropost.save
      flash[:success] = "Micropost created!"
      if current_user.admin?
        redirect_to user
      else
        redirect_to root_url
      end
    else
      @feed_items = []
      render 'static_pages/home'
    end
    session[:showing_user_id] = nil
  end

  def destroy
    @micropost.destroy
    redirect_to @user
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = Micropost.find_by(id: params[:id])
      @user = @micropost.user 
      redirect_to @user if current_user.microposts.find_by(id: params[:id]).nil? && !current_user.admin?
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end