require 'rails_helper'

RSpec.describe Api::V1::PanelsController, type: :controller do

  describe "GET #show" do
    let!(:panel){ create(:panel) }

    before(:each) do
      get :show, id: panel, format: :json
    end

    it "returns a panel" do
      panel_response = json_response
      expect(panel_response[:caption]).to eql panel.caption
      expect(response.status).to eq(200)
    end
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :panel }
      get :index, format: :json
    end

    it "returns 4 records from the database" do
      panels_response = json_response
      expect(panels_response.count).to be(4)
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do

    context "when is successfully created" do
      let(:panel_attributes) { attributes_for(:panel) }

      before(:each) do
        post :create, { panel: panel_attributes }, format: :json
      end

      it "renders the json representation for the panel record just created" do
        panel_response = json_response
        expect(panel_response[:caption]).to eql panel_attributes[:caption]
        expect(response.status).to eq(201)
      end
    end

    context "when is not created" do
      before(:each) do
        @invalid_panel_attributes = { image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/image_2.pdf", "image/pdf") }
        post :create, { panel: @invalid_panel_attributes }, format: :json
      end

      it "renders an errors json" do
        panel_response = json_response
        expect(panel_response).to have_key(:errors)
      end

      it "renders the json errors on why the panel could not be created" do
        panel_response = json_response
        expect(panel_response[:errors][:image]).to include "has contents that are not what they are reported to be"
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT/PATCH #update" do
    let(:panel){ create(:panel) }

    context "when is successfully updated" do
      before(:each) do
        patch :update, { id: panel.id, panel: { caption: "new caption" } }
      end

      it "renders the json representation for the updated panel" do
        panel_response = json_response
        expect(panel_response[:caption]).to eql "new caption"
        expect(response.status).to eq(200)
      end
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { id: panel.id, panel: { image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/image_2.pdf", "image/pdf") } }
      end

      it "renders an errors json" do
        panel_response = json_response
        expect(panel_response).to have_key(:errors)
      end

      it "renders the json errors on why the panel could not be created" do
        panel_response = json_response
        expect(panel_response[:errors][:image]).to include "has contents that are not what they are reported to be"
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:panel) { create(:panel) }
    before(:each) do
      delete :destroy, { id: panel.id }, format: :json
    end

    it "returns no content status"do
      expect(response.status).to eq(204)
    end
  end

end
