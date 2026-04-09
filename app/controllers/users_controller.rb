class UsersController < ApplicationController
  # ログインしていない人は見れないようにする
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    # どの編集フォームから来たかによって、パラメータを切り替える
    case params[:update_type]
    when "account"
      if @user.update(account_params)
        redirect_to user_path(@user, type: "account"), notice: "アカウント情報を更新しました"
      else
        render :edit, status: :unprocessable_entity
      end

    when "profile"
      if @user.update(profile_params)
        redirect_to user_path(@user, type: "profile"), notice: "プロフィールを更新しました"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private

  # ストロングパラメータ(アカウント用)
  def account_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # ストロングパラメータ(プロフィール用)
  def profile_params
    params.require(:user).permit(:image, :name, :introduction)
  end
end
