class Location < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
	validates :address1, presence: true
	validates :city, presence: true
	#validates :state, presence: true  #How do we validate for states now that they are in a hash variable?
	validates :zipcode, presence: true

	has_many :events

	STATE_LIST =[['Alabama','AL'],['AK','Alaska'],['AZ','Arizona'],['AR','Arkansas'],['California','CA'],['Colorado','CO'],['Connecticut','CT'],['Delaware','DE'],['Florida','FL'],['Georgia','GA'],['Hawaii','HI'],['Idaho','ID'],['Illinois','IL'],['Indiana','IN'],['Iowa','IA'],['Kansas','KS'],['Kentucky','KY'],['Louisiana','LA'],['Maine','ME'],['Maryland','MD'],['Massachusetts','MA'],['Michigan','MI'],['Minnesota','MN'],['Mississippi','MS'],['Missouri','MO'],['Montana','MT'],['Nebraska','NE'],['Nevada','NV'],['New Hampshire','NH'],['New Jersey','NJ'],['New Mexico','NM'],['New York','NY'],['North Carolina','NC'],['North Dakota','ND'],['Ohio','OH'],['Oklahoma','OK'],['Oregon','OR'],['Pennsylvania','PA'],['Rhode Island','RI'],['South Carolina','SC'],['South Dakota','SD'],['Tennessee','TN'],['Texas','TX'],['Utah','UT'],['Vermont','VT'],['Virginia','VA'],['Washington','WA'],['West Virginia','WV'],['Wisconsin','WI'],['Wyoming','WY']]
end
