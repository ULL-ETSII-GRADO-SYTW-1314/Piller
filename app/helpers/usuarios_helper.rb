module UsuariosHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(usuario , options = { size: 10 })
    gravatar_id = Digest::MD5::hexdigest(usuario.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: usuario.name, class: "gravatar")
  end
end
