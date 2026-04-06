class UsersController < ApplicationController
  #ログインしていない人は見れないようにする
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
end
