class State < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :abbrv, presence: true, uniqueness: true
end
