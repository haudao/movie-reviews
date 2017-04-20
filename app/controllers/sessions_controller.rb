class SessionsController < ApplicationController
  layout 'user'

  before_filter :store_return_to

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to session.delete(:return_to)
    else
      flash.now[:alert] = 'Tên người dùng hoặc mật khẩu không đúng!'
      render action: :new
    end
  end

  def destroy
    reset_session
    redirect_to :back, notice: 'Đăng xuất thành công.'
  end

  private

  def store_return_to
    session[:return_to] ||= request.referer
  end
end
