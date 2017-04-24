require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  include SpecTestHelper

  let!(:mv) { create(:movie) }

  describe 'GET #new' do
    context 'when logged in' do
      before do
        login
      end
      it 'render new comment form' do
        get :new, movie_id: mv.id
        expect(response).to render_template :new
      end
    end

    context 'when not logged in' do
      it 'redirects to the movie page with alert' do
        get :new, movie_id: mv.id
        expect(response).to redirect_to mv
        expect(flash[:alert]).to eq('Vui lòng đăng nhập để bình luận!')
      end
    end
  end

  describe 'POST #create' do
    before do
      login
    end

    context 'with valid attributes' do
      it 'creates new comment' do
        post :create, comment: attributes_for(:comment), movie_id: mv.id
        expect(mv.comments.count).to eq(1)
      end

      it 'redirects to the movie page' do
        post :create, comment: attributes_for(:comment), movie_id: mv.id
        expect(response).to redirect_to mv
      end
    end

    context 'with invalid attributes' do
      it 'does not creat new comment' do
        post :create, comment: attributes_for(:comment, rating: nil), movie_id: mv.id
        expect(mv.comments.count).to eq(0)
      end

      it 'renders new comment form' do
        post :create, comment: attributes_for(:comment, rating: nil), movie_id: mv.id
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login
    end
    it 'deletes the comment' do
      cmt = create(:comment, movie_id: mv.id)
      delete :destroy, id: cmt.id, movie_id: mv.id
      expect(mv.comments.count).to eq(0)
    end

    it 'redirects to the movie page' do
      cmt = create(:comment, movie_id: mv.id)
      delete :destroy, id: cmt.id, movie_id: mv.id
      expect(response).to redirect_to mv
    end
  end
end
