=begin
require 'spec_helper'
	describe "Static pages" do
		describe "Home page" do
			before { visit home_path }

    		it { should have_selector('h1',    text: 'Piller') }
    		it { should have_selector('title', text: full_title('')) }
    		it { should_not have_selector 'title', text: 'Proyecto SYTW Piller | Home' }
			
		end
		describe "Help page" do
    		before { visit help_path }

    		it { should have_selector('h1',    text: 'Pagina de ayuda') }
    		it { should have_selector('title', text: full_title('Help')) }
  		end

  		describe "About page" do
   		 	before { visit about_path }

    		it { should have_selector('h1',    text: 'Quienes Somos') }
    		it { should have_selector('title', text: full_title('Quienes Somos')) }
  		end

  		describe "Contact page" do
    		before { visit contact_path }

    		it { should have_selector('h1',    text: 'Contacta') }
    		it { should have_selector('title', text: full_title('Contacta')) }
  end
end
=end
require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Home') }
    it { should have_title(full_title('Home')) }
    it { should_not have_title('Proyecto Piller Home') }

    describe "for signed-in users" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      before do
        FactoryGirl.create(:microvideo, usuario: usuario, content: "http://www.youtube.com/watch?v=9nqr8BSvoz0")
        FactoryGirl.create(:microvideo, usuario: usuario, content: "http://www.youtube.com/watch?v=xyzxyzxyzz0")
        sign_in usuario
        visit root_path
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:usuario) }
        before do
          other_user.follow!(usuario)
          visit root_path
        end

        it { should have_link("0 following", href: following_usuario_path(usuario)) }
        it { should have_link("1 followers", href: followers_usuario_path(usuario)) }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Pagina de ayuda') }
    it { should have_title(full_title('Ayuda')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('Quienes Somos') }
    it { should have_title(full_title('Quienes Somos')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contacta con PILLER') }
    it { should have_title(full_title('Contacto')) }
  end
end