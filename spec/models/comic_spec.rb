require 'rails_helper'

RSpec.describe Comic, type: :model do
  it { is_expected.to have_many :panels}

  describe "comics association" do
    let(:comic) { create(:comic) }

    before do
      3.times { FactoryGirl.create :panel, comic: comic}
    end

    it "destroys the associated panels on destro/delete" do
      panels = comic.panels
      comic.destroy
      panels.each do |panel|
        expect(Panel.find(panel)).to  raise_error ActiveRecord::RecordNotFound
      end
    end
  end


end
