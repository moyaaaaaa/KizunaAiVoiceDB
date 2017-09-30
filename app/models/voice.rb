class Voice < ApplicationRecord
  validates :filename, presence: true,
            length: { maximum: 255 },
            uniqueness: true
  validates :line, presence: true,
            length: { maximum: 255 }
end
