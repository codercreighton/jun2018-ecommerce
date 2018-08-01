class AdminController < ApplicationController
  def user_list
  	authorize! :manage, User
  	@users = User.order(:role)
  end

  def edit_user
  	@user = User.find(params[:id].to_i)
		@user.update(role: params[:role])
		redirect_to users_path
  end

  def delete_user
  	@user = User.find(params[:id].to_i)
  	@user.delete
  	redirect_to users_path
  end	
end
