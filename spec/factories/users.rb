require 'digest'

FactoryGirl.define do
  factory :user do
    username 'haudao'
    email 'hd@eh.com'
    password 'abc123'
    password_confirmation 'abc123'
  end

  factory :user1, class: User do
    username 'haudao'
    email 'eh@eh.com'
    password '123456'
    password_confirmation '123456'
  end

  factory :user2, class: User do
    username 'abcdef'
    email 'hd@eh.com'
    password '123456'
    password_confirmation '123456'
  end

  factory :user3, class: User do
    username 'haudao1'
    email 'hd1@email.com'
    password '123456'
    password_confirmation '123456'
  end
end
