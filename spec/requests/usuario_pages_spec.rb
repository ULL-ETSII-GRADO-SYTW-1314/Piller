require 'spec_helper'

describe "Usuario pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Registrate') }
    #it { should have_selector('title', text: full_title('Registrate')) }
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
      it { should have_link('Salir', href: signout_path) }
      specify { expect(usuario.reload.name).to  eq new_name }
      specify { expect(usuario.reload.email).to eq new_email }
    end
  end

  describe "profile page" do
    let(:usuario) { FactoryGirl.create(:usuario) }

    describe "follow/unfollow buttons" do
      let(:other_usuario) { FactoryGirl.create(:usuario) }
      before { sign_in usuario }

      describe "following a user" do
        before { visit usuario_path(other_usuario) }

        it "should increment the followed user count" do
          expect do
            click_button "Seguir"
          end.to change(usuario.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Seguir"
          end.to change(other_usuario.followers, :count).by(1)
        end
      end

      describe "unfollowing a user" do
        before do
          usuario.follow!(other_usuario)
          visit usuario_path(other_usuario)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Dejar de Seguir"
          end.to change(usuario.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Dejar de Seguir"
          end.to change(other_usuario.followers, :count).by(-1)
        end
      end
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

      it { should have_link(other_usuario.name, href: usuario_path(other_usuario)) }
    end

    describe "followers" do
      before do
        sign_in other_usuario
        visit followers_usuario_path(other_usuario)
      end

      it { should have_link(usuario.name, href: usuario_path(usuario)) }
    end

    describe "followers" do
      before do
        sign_in other_usuario
        visit followers_usuario_path(other_usuario)
      end

      it { should have_link(usuario.name, href: usuario_path(usuario)) }
    end

  end  
end
