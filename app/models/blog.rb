class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments

  before_save :generate_slug


  def to_objects
    {
        id: id,
        user: user.to_objects,
        title: title,
        description: description,
        slug: slug,
        comments: comments.map(&:to_objects)
    }
  end

  private

  def self.active
    where(is_active: true)
  end

  def generate_slug
    self.slug = title.parameterize
  end
end
