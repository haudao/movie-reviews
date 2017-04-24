require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders sign up form' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        post :create, user: attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it 'redirects to home page' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user' do
        post :create, user: attributes_for(:user, username: '')
        expect(User.count).to eq(0)
      end

      it 'renders sign up form again' do
        post :create, user: attributes_for(:user, email: 'abc')
        expect(response).to render_template :new
      end
    end
  end
end
