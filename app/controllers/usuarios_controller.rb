class UsuariosController < ApplicationController
  #before_action :signed_in_user,
  #              only: [:index, :edit, :update, :destroy, :following, :followers]
  #before_action :correct_user,   only: [:edit, :update]
  #before_action :admin_user,     only: :destroy
  
  def new
  	@usuario = Usuario.new
  end
  
  def show
    @usuario = Usuario.find(params[:id])
    @microvideos = @usuario.microvideos.paginate(page: params[:page])
  end

  def create
    @usuario = Usuario.new(user_params)    # Not the final implementation!
    if @usuario.save
      sign_in @usuario
      flash[:success] = "Welcome to Piller!"
      redirect_to @usuario
    else
      render 'new'
    end
  end

  def destroy
    Usuario.find(params[:id]).destroy
    flash[:success] = "Usuario destroyed."
    redirect_to usuarios_path
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @usuario
      redirect_to @usuario
    else
      render 'edit'
    end
  end

  def index
    @usuarios = Usuario.paginate(page: params[:page])
  end

  def following
    @title = "Following"
    @usuario = Usuario.find(params[:id])
    @usuarios = @usuario.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @usuario = Usuario.find(params[:id])
    @usuarios = @usuario.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:usuario).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    def signed_in_usuario
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
    def correct_usuario
      @usuario = Usuario.find(params[:id])
      redirect_to(root_url) unless current_usuario?(@usuario)
    end
    def admin_usuario
      redirect_to(root_url) unless current_usuario.admin?
    end
end
