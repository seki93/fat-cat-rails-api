class User < ApplicationRecord
  validates :password, presence: true, length: { minimum: 3 }
end
