class Lodging < ActiveRecord::Base
	
	#has_and_belongs_to_many :events
  has_many :hospitalities
  has_many :events, -> { uniq }, through: :hospitalities
	has_one :contact_person, class_name: 'User' 
  belongs_to :locality

  accepts_nested_attributes_for :contact_person
  
	validates :name, presence: true
	validates :address1, presence: true
	validates :city, presence: true
	validates :state_abbrv, presence: true
	validates :zipcode, presence: true
	validates :lodging_type, presence: true
	validates :contact_person, presence: true

	LODGING_TYPE= [['Home',1],['Retreat Center',2],['Hotel/Motel',3]]
	
	def display_address
		if (self.address1 != nil && self.city != nil && self.state_abbrv != nil && self.zipcode != nil)
		"#{self.address1} \n #{self.city}, #{self.state_abbrv}  #{self.zipcode}" 
		else
			"--"
		end
	end

	def display_description
		if self.description == nil
			'--'
		else
			self.description
		end
	end

  def contact_person_home_phone
    home_phone = self.contact_person.home_phone
    if home_phone.nil?
      '--'
    else
      home_phone
    end
  end

  def contact_person_cell_phone
    cell_phone = self.contact_person.cell_phone 
    if cell_phone.nil?
      '--'
    else
      cell_phone
    end
  end

  def address
    self.address1 + ' ' + self.city + ', ' + self.state_abbrv + '  ' + self.zipcode.to_s
  end

  def display_min_capacity
    if self.min_capacity.nil?
      '--'
    else
      self.min_capacity
    end
  end

  def display_max_capacity
    if self.max_capacity.nil?
      '--'
    else
      self.max_capacity
    end
  end
end
