class Tweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments
  validates :text, :image, presence: true
end
