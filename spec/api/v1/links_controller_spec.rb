require 'rails_helper'

describe Api::V1::LinksController do
  describe "PATCH #update", type: :controller do
    it "returns 204 response when idea is updated" do
      link = create(:link)

      patch :update, format: :json, id: link.id, link: {read: true}

      link.reload

      expect(response.status).to eq 204
      expect(link.read).to eq true
    end
  end
end
