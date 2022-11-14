class Post < ApplicationRecord
  belongs_to :user

  def self.search(word)
    where(["body like?", "%#{word}%"])
  end
end
