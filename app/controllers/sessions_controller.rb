class SessionsController < ApplicationController
  layout 'user'

  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = 'Tên người dùng hoặc mật khẩu không đúng!'
      render action: :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Đăng xuất thành công.'
  end
end
