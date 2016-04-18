FactoryGirl.define do
  factory :user do
    email "Gob@gmail.com"
    password "password"

    factory :user_with_links do
      transient do
        links_count 1
      end
      after(:create) do |user, evaluator|
        create_list(:link, evaluator.links_count, user: user)
      end
    end
  end

  factory :link do
    url "http://www.arrested-development.com"
    title "AD"
  end
end
