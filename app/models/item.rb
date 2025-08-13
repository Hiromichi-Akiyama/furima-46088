class Item < ApplicationRecord
  belongs_to :user
  # has_one :order # orderテーブル作成後にコメントを外します
end
