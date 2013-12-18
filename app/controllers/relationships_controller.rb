class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @usuario = usuario.find(params[:relationship][:followed_id])
    current_usuario.follow!(@usuario)
    redirect_to @usuario
  end

  def destroy
    @usuario = Relationship.find(params[:id]).followed
    current_usuario.unfollow!(@usuario)
    redirect_to @usuario
  end
end