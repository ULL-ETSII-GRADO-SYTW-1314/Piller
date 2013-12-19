require 'spec_helper'

describe "Usuario pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Registrate') }
    it { should have_title(full_title('Registrate')) }
  end
  
  describe "edit" do
    let(:usuario) { FactoryGirl.create(:usuario) }
    before { visit edit_usuario_path(usuario) }

    describe "page" do
      it { should have_content("Actualiza tu perfil") }
      it { should have_title("Editar perfil") }
      it { should have_link('Cambiar', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Guardar" }
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }

      before do
        fill_in "Nombre",             with: new_name
        fill_in "Email",              with: new_email
        fill_in "Password",           with: usuario.password
        fill_in "Confirm Password",   with: usuario.password
        click_button "Guardar"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(usuario.reload.name).to  eq new_name }
      specify { expect(usuario.reload.email).to eq new_email }
    end
  end

  describe "following/followers" do
    let(:usuario) { FactoryGirl.create(:usuario) }
    let(:other_usuario) { FactoryGirl.create(:usuario) }
    before { usuario.follow!(other_usuario) }

    describe "followed usuarios" do
      before do
        sign_in usuario
        visit following_usuario_path(usuario)
      end

      it { should have_title(full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_usuario.name, href: usuario_path(other_usuario)) }
    end

    describe "followers" do
      before do
        sign_in other_usuario
        visit followers_usuario_path(other_usuario)
      end

      it { should have_title(full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(usuario.name, href: usuario_path(usuario)) }
    end
  end  
end
