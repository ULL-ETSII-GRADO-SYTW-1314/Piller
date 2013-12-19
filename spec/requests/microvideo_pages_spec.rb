require 'spec_helper'

describe "Microvideo pages" do

  subject { page }

  let(:usuario) { FactoryGirl.create(:usuario) }
  before { sign_in usuario }

  describe "microvideo creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a microvideo" do
        expect { click_button "Publicar" }.not_to change(Microvideo, :count)
      end

      describe "error messages" do
        before { click_button "Publicar" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'microvideo_content', with: "http://www.youtube.com/watch?v=9nqr8BSvoz0" } 
      before { fill_in 'microvideo_titulo', with: "http://www.youtube.com/watch?v=vcvcvccvoz0" }
      it "should create a microvideo" do
        expect { click_button "Publicar" }.to change(Microvideo, :count).by(1)
      end
    end
  end
end