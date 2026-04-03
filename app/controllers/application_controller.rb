class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? #アクション前に独自メソッドを実行

  protected #ApplicationControllerを継承した子クラス(Deviseなど)からのみアクセス可能

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) #sign_upの際にnameカラムの保存を許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction]) #account_updateの際にname,introductionカラムの保存を許可
  end
end
