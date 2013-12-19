# By using the symbol ':usuario', we get Factory Girl to simulate the usuario model.
FactoryGirl.define do
  factory :usuario do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true 
    end
  end

  factory :microvideo do
    content "http://www.youtube.com/watch?v=xxxxxxxxxxx"
    titulo "Lorem ipsum"
    comentario "Comentarios..."
    usuario
  end
end