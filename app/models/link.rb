class Link < ActiveRecord::Base
  belongs_to :user
  validate :must_have_valid_url

  private

  def must_have_valid_url
    errors.add(:url, "is not valid") unless valid_url?
  end

  def valid_url?
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end
end
