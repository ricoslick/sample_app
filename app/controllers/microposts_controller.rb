class MicropostsController < ApplicationController

	before_action :signed_in_user, only: [:create, :destroy]

  def new
  end

  def index
  end

  def create
  	Micropost.create(micropost_params)
  end

  def destroy
  end

  private

  def micropost_params
  	params.require(:micropost).permit(:content, :user_id)
  end

end
