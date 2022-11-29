class Room < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings
  has_one_attached :room_image

  validate :acceptable_image

  private

  def acceptable_image
    # if image is attached only then will we validate
    return unless room_image.attached?

    # if file size is greater than 1 MB then too big
    errors.add(:room_image, "is too big") unless room_image.byte_size <= 5.megabyte

    # checking if file is jpeg/png or not
    acceptable_types = ["image/jpeg", "image/png", "image/jpg"]
    return if acceptable_types.include?(room_image.blob.content_type)

    errors.add(:room_image, "must be a JPEG/JPG, PNG or GIF")
  end
end
