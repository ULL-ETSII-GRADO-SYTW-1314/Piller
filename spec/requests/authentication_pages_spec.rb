require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
    end

    describe "with valid information" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      before { sign_in usuario }
        fill_in "Email",    with: usuario.email.upcase
        fill_in "Password", with: usuario.password
        click_button "Sign in"

      it { should have_title(usuario.name) }
      it { should have_link('Profile',     href: usuario_path(usuario)) }
      it { should have_link('Settings',    href: edit_usuario_path(usuario)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      	describe "followed by signout" do
        	before { click_link "Sign out" }
        	it { should_not have_link('Sign in') }
      	end
    end
  end

  describe "authorization" do

    describe "for non-signed-in usuarios" do
      let(:usuario) { FactoryGirl.create(:usuario) }

      describe "in the usuers controller" do

        describe "visiting the edit page" do
          before { visit edit_usuario_path(usuario) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch usuario_path(usuario) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "in the Relationships controller" do
          describe "submitting to the create action" do
            before { post relationships_path }
            specify { expect(response).to redirect_to(signin_path) }
          end

          describe "submitting to the destroy action" do
            before { delete relationship_path(1) }
            specify { expect(response).to redirect_to(signin_path) }
          end
        end

        describe "visiting the following page" do
          before { visit following_usuario_path(usuario) }
          it { should have_title('Sign in') }
        end

        describe "visiting the followers page" do
          before { visit followers_usuario_path(usuario) }
          it { should have_title('Sign in') }
        end

        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it { should have_title('Sign in') }
        end
        
      end
    end
  end
end
