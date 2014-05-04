# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence(:title) {|n| "Sample Event #{n}" }
  factory :event do
    title { generate(:title) }
		event_type 'Conference'
		begin_date '20/01/01' #'01/01/2020'
		end_date '20/01/03' #'01/03/2020'
		registration_open_date '19/08/01' # '08/01/2019'
		registration_close_date '19/11/01' #'11/01/2019'
		registration_cost '10'
		location
  end
end
