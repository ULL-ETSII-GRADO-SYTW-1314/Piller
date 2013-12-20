require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Acceder') }
    it { should have_title('Acceder') }
  end
  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Entrar" }

      it { should have_title('Acceder') }
    end

    describe "with valid information" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      #before { sign_in usuario }
      before do
        fill_in "Email",    with: usuario.email.upcase
        fill_in "Password", with: usuario.password
        click_button "Entrar"
      end

      it { should have_title(usuario.name) }
      it { should have_link('Perfil',     href: usuario_path(usuario)) }
      it { should have_link('Configuracion',    href: edit_usuario_path(usuario)) }
      it { should have_link('Salir',    href: signout_path) }
      it { should_not have_link('Acceder', href: signin_path) }

      describe "followed by signout" do
       	before { click_link "Salir" }
       	it { should_not have_link('Acceder') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in usuarios" do
      let(:usuario) { FactoryGirl.create(:usuario) }

      describe "in the usuers controller" do

        describe "visiting the edit page" do
          before { visit edit_usuario_path(usuario) }
          it { should have_title('Editar perfil') }
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
      end
    end
  end
end
