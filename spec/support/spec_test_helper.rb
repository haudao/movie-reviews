module SpecTestHelper
  def login
    usr = create(:user)
    session[:user_id] = usr.id
  end
end
