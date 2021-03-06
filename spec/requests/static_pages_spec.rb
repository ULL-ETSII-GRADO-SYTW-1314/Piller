require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Inicio page" do
    before { visit root_path }

    it { should have_content('Inicio') }
    it { should have_title(full_title('Inicio')) }
    it { should_not have_title('Proyecto Piller Inicio') }

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