namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microvideos
    make_relationships
  end
end

def make_users
  admin = Usuario.create!(name:     "Example Usuario",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    Usuario.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microvideos
  usuario = Usuario.all(limit: 6)
  5.times do
    titulo = " Titulo "
    content = "http://www.youtube.com/watch?v=9nqr8BSvoz0"
    comentario = " Comentarios... "
    usuario.each { |usuario| usuario.microvideos.create!(content: content, titulo: titulo, comentario: comentario) }
end

end

def make_relationships
  usuarios = Usuario.all
  usuario  = usuarios.first
  followed_usuarios = usuarios[2..50]
  followers      = usuarios[3..40]
  followed_usuarios.each { |followed| usuario.follow!(followed) }
  followers.each      { |follower| follower.follow!(usuario) }
end