class Post < ApplicationRecord
  belongs_to :user

  validates :title, :description, :repo_link, :demo_link, :screenshot, presence: true
  validates :is_public, inclusion: { in: [true, false] }

  before_validation :generate_slug, on: :create

  validates :slug, presence: true
  validate :unique_slug_per_user

  has_one_attached :screenshot

  def generate_slug
    if title.present? && slug.blank?
      self.slug = title.parameterize(separator: '_')
    end
  end

  def unique_slug_per_user
    if self.class.where(user_id: user_id, slug: slug).where.not(id: id).exists?
      errors.add(:base, "You have already used this title for another project. Please choose a new one.")
    end
  end
end

