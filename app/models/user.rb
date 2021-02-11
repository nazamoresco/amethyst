class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books

  after_create :create_default_book

  def create_default_book
    Book.create(title: Rails.application.config.default_book, user: self)
  end
end
