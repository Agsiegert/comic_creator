require 'rails_helper'

RSpec.describe Api::V1::ComicsController, type: :controller do

  describe "GET #show" do
    let(:comic){ create(:comic) }

    before(:each) do
      get :show, id: comic.id, format: :json
    end

    it "returns a comic" do
      comic_response = json_response
      expect(comic_response[:id]).to eql comic.id
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do

    context "when is successfully created" do
      let(:comic_attributes) { attributes_for(:comic) }

      before(:each) do
        post :create, { comic: comic_attributes }, format: :json
      end

      it "renders the json representation for the comic record just created" do
        comic_response = json_response
        expect(comic_response[:title]).to eql comic_attributes[:title]
        expect(response.status).to eq(201)
      end

      xit "creates embeded panels" do
      end

    end

    context "when is not created" do
      before(:each) do
                                  #@@TODO
        @invalid_comic_attributes = {  }
        post :create, { comic: @invalid_comic_attributes }, format: :json
      end

      xit "renders an errors json" do
        comic_response = json_response
        expect(comic_response).to have_key(:errors)
      end

      xit "renders the json errors on why the comic could not be created" do
        comic_response = json_response
                                      #@@TODO
        expect(comic_response[:errors][]).to include "can't be blank"
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT/PATCH #update" do
    let(:comic){ create(:comic) }

    context "when is successfully updated" do
      before(:each) do
        patch :update, { id: comic.id, comic: { title: "new title" } }
      end

      it "renders the json representation for the updated comic" do
        comic_response = json_response
        expect(comic_response[:title]).to eql "new title"
        expect(response.status).to eq(200)
      end
    end

    context "when is not updated" do
      before(:each) do
                                                #@@TODO
        patch :update, { id: comic.id, comic: { title: 7 } }
      end

      xit "renders an errors json" do
        comic_response = json_response
        expect(comic_response).to have_key(:errors)
      end

      xit "renders the json errors on why the comic could not be created" do
        comic_response = json_response
                                        #@@TODO
        expect(comic_response[:errors][:title]).to include "is invalid"
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:comic) { create(:comic) }
    before(:each) do
      delete :destroy, { id: comic.id }, format: :json
    end

    it "returns no content status"do
      expect(response.status).to eq(204)
    end
  end
end
