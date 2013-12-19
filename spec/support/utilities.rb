def full_title(page_title)
  base_title = "PILLER"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def valid_signin(usuario)
  fill_in "Email",    with: usuario.email
  fill_in "Password", with: usuario.password
  click_button "Acceder"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

def sign_in(usuario)
  visit signin_path
  fill_in "Email",    with: usuario.email
  fill_in "Password", with: usuario.password
  click_button "Acceder"
  # Acceder when not using Capybara as well.
  cookies[:remember_token] = usuario.remember_token
end

def sign_in(usuario, options={})
  if options[:no_capybara]
    # Acceder when not using Capybara.
    remember_token = Usuario.new_remember_token
    cookies[:remember_token] = remember_token
    usuario.update_attribute(:remember_token, Usuario.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: usuario.email
    fill_in "Password", with: usuario.password
    click_button "Entrar"
  end
end