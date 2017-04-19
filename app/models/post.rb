class Post < ApplicationRecord
  validates :url, :format => URI::regexp(%w(http https)), presence: true

  belongs_to :user
end
