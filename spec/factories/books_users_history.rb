FactoryGirl.define do
  factory :books_users_history do
    user
    book
    lending_date '10/07/2017'
    returning_date nil
  end
end
