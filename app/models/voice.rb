class Voice < ApplicationRecord
  mount_uploader :voice_file, VoiceFileUploader
  serialize :voice_file, JSON

  validates :voice_file, presence: true, uniqueness: true
  validates :line, presence: true,
            length: { maximum: 255 }
  validates :url, presence: true

  def embed_url
    uri = URI(url)
    queries = Hash[URI.decode_www_form(uri.query)]
    uri = URI.join(uri.to_s, "/embed/#{queries['v']}/")
    p uri
    queries.reject! { |k, v| k == 't' || k == 'v' }
    queries[:start] = "#{start.to_i}"
    uri.query = URI.encode_www_form(queries.to_a)
    uri.to_s
  end
end
