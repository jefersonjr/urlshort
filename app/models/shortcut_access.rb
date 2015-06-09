class ShortcutAccess
  include Mongoid::Document

  field :access_ip,     type: String, default: ''
  field :access_date,   type: DateTime
  belongs_to :shortcut
end