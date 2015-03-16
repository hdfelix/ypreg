class EventLocality < ActiveRecord::Base
  self.table_name = 'events_localities'
  belongs_to :event
  belongs_to :locality
end
