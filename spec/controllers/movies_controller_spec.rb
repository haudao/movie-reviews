require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET #index' do
    it 'render the home page' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET show' do
    it 'show movies details page' do
      mv = create(:movie)
      get :show, id: mv.id
      expect(response). to render_template :show
    end
  end
end
