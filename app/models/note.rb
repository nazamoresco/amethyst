class Note < ApplicationRecord
  belongs_to :book

  validates :title, presence: true
  validates :content, presence: true
  validates :book, presence: true
end
