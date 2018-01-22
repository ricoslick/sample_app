class MicropostsController < ApplicationController

	before_action :signed_in_user, only: [:create, :destroy]

  def new
    @micropost = Micropost.new
  end

  def index
  end

  def create
  	Micropost.new(micropost_params)

    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    if @micropost.present?
      @micropost.destroy
    end
    flash[:success] = "Micropost deleted!"
    redirect_to root_path
  end

  private

  def micropost_params
  	params.require(:micropost).permit(:content, :user_id)
  end

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end
end
