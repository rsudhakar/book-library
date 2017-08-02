FactoryGirl.define do
  factory :book do
    book_info
    user
    serial_no '12345678'
    damaged false
    lost false
  end
end
