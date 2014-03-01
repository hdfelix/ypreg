# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "Factory Title"
		begin_date '01/01/2020'
		end_date '01/03/2020'
		registration_cost '10'
  end
end
