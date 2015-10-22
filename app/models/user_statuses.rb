class UserStatuses
  include Virtus.model

  attribute :background_check, String

  def self.dump(preferences)
    preferences.to_hash
  end

  def self.load(preferences)
    new(preferences)
  end
end
