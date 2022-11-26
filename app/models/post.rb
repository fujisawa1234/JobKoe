class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

  validates :body, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #投稿文検索
  def self.search(word)
    where(["body like?", "%#{word}%"])
  end


  #タグ保存時に新規か既存か確認
  def save_tag(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?

    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      new_post_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << new_post_tag
    end
  end
end
