FactoryBot.define do
  factory :course do
    name { 'Ruby on Rails' }
    description { 'Um curso de Ruby' }
    code { '9d04efe4dc41e0f0c4ci' }
    time { '40 horas' }
    teacher
  end
end
