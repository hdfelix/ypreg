# A local church
class Locality < ActiveRecord::Base
  has_many :users
  has_many :lodgings
  belongs_to :contact, class_name: 'User', foreign_key: 'contact_id'
  belongs_to :lodging_contact, class_name: 'User', foreign_key: 'lodging_contact_id'
  # has_and_belongs_to_many :lodgings

  validates :city, presence: true
  validates :state_abbrv, presence: true

  def contact_name
    if contact.nil?
      '--'
    else
      contact.name
    end
  end

  def contact_with_email
    if contact.nil?
      '--'
    else
      contact = User.find(contact_id)
      "#{contact.name} (#{contact.email})"
    end
  end

  def contact_with_email_and_cell
    if contact.nil?
      '--'
    else
      contact_string = ""
      contact.cell_phone.nil?? contact_string = ')': contact_string << ", #{format_phone_number(contact.cell_phone)})"
      contact.email.nil?? contact_string.prepend("#{contact.name} (") : contact_string.prepend("#{contact.name} (#{contact.email}")
      contact_string
    end
  end

  def hospitalities(event)
    Hospitality.where(event: event, locality: self)
  end
  
  def hospitality_lodgings(event)
    Lodging.joins(:hospitalities).where(locality: self, event: event)
  end

  # Registrations Scopes
  def registrations(event)
    Registration.where(event: event, locality: self)    
  end

  def registered_users(event)
    User.find(registrations(event).map(&:user_id))
  end

  def registered_yp(event)
    registered_users(event).reject { |u| u.role != 'yp' }
  end
  
  def registered_serving_ones(event)
    registrations(event).reject { |r| !r.attend_as_serving_one }
  end

  def registered_helpers(event)
    registered_users(event).reject { |u| u.role != 'helper' }
  end

  def registered_trainees(event)
    registered_users(event).reject { |u| u.role != 'trainee' }
  end

  def users_not_registered(event)
    users - registered_users(event)
  end

  private

  def format_phone_number(phone)
    unless phone.nil?
      tmp = phone
      if tmp.length == 7
        tmp.insert(3,') ').insert(0,'(')
      elsif tmp.length == 10
        tmp.insert(6,'-').insert(3,') ').insert(0,'(')
      end
    else
      '--'
    end
  end
end
