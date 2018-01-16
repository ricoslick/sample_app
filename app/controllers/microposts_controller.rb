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
  end

  private

  def micropost_params
  	params.require(:micropost).permit(:content, :user_id)
  end
end
