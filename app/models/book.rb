class Book < ApplicationRecord
  has_many :notes
  belongs_to :user
  validate :not_default, on: [:update, :destroy]

  before_destroy :not_default, prepend: true do
    throw(:abort) if errors.present?
  end

  private

  def not_default
    if title == Rails.application.config.default_book
      errors.add(:title, "Default book is not editable nor destroyable!")
    end
  end
end
