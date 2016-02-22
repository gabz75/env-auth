class Token < ActiveRecord::Base
  belongs_to :account

  # validates :token, presence: true
end
