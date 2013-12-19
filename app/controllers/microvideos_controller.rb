class MicrovideosController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
    @microvideo = current_usuario.microvideos.build(microvideo_params)
    if @microvideo.save
      flash[:success] = "Microvideo created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @microvideo.destroy
    redirect_to root_url
  end

  private
    def microvideo_params
      params.require(:microvideo).permit(:content, :titulo, :comentario)
    end

    def correct_user
        @microvideo = current_usuario.microvideos.find(params[:id])
    rescue
        redirect_to root_url
    end
end

  private

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end