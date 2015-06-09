class Shortcut
  include Mongoid::Document
  before_create :generate_short_url
  validate :validate_url

  field :full_url,                type: String, default: ""
  field :short_url,               type: String, default: ""
  field :created_at,              type: DateTime
  field :hits,                    type: Integer, default: 0
  belongs_to :user, index: true

  # Validate URL format
  def validate_url
    unless self.full_url.present?
      errors.add(:full_url, 'cannot be empty.')
    end

    # Fix HTTP in URL
    unless full_url =~ /http/
      self.full_url = "http://#{full_url}"
    end

    if (self.full_url =~ URI::regexp).nil?
      errors.add(:full_url, 'is not valid. :(')
    end
  end

  # Generate short URL for this Shortcut
  def generate_short_url
    url = rand(36**8).to_s(36)

    # If generated token already exists, execute again
    if Shortcut.where(short_url: url).count > 0
      generate_short_url
      return
    end

    # Generated short url
    self.short_url = url
  end

end