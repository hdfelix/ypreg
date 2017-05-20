class LocalityDecorator < Draper::Decorator
  delegate :city, :state

end
