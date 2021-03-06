class RelationshipsController < ApplicationController
  before_action :signed_in_usuario

  def create
    @usuario = User.find(params[:relationship][:followed_id])
    current_usuario.follow!(@usuario)
    respond_to do |format|
      format.html { redirect_to @usuario }
      format.js
    end
  end

  def destroy
    @usuario = Relationship.find(params[:id]).followed
    current_usuario.unfollow!(@usuario)
    respond_to do |format|
      format.html { redirect_to @usuario }
      format.js
    end
  end
end