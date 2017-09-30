class Voice < ApplicationRecord
  mount_uploader :voice_file, VoiceFileUploader
  serialize :voice_file, JSON

  validates :voice_file, presence: true, uniqueness: true
  validates :line, presence: true,
            length: { maximum: 255 }
end
