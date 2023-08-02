class Comment < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', :allow_nil => true

  has_many :comments, foreign_key: :parent_id

  def to_objects
    {
      id: id,
      comment: comment,
      nested: comments.map(&:to_objects)
    }
  end
end
