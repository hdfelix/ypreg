# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence(:title) {|n| "Sample Event #{n}" }
  tmp_date = Time.now + 2.months
  factory :event do
    title { generate(:title) }
		event_type '3'  #
    begin_date tmp_date 
    end_date (tmp_date + 3.days).strftime('%Y/%m/%d') 
    registration_open_date (tmp_date - 1.month).strftime('%Y/%m/%d') 
    registration_close_date (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d') 
		registration_cost '10'
		location
  end
end
