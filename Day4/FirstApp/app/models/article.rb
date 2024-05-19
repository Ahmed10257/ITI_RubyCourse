class Article < ApplicationRecord
  include Visible
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  def self.public_count
    where(visible: true).count
  end

  def report
    self.report_count = (self.report_count || 0) + 1
    self.save
  end

  has_many :comments, dependent: :destroy
end
