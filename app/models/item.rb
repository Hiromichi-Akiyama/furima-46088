class Item < ApplicationRecord
  # ActiveStorage
  has_one_attached :image

  # ActiveHash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :shipping_day

  belongs_to :user
  has_one :order

  # --- presence: true のバリデーション ---
  with_options presence: true do
    validates :image
    validates :name,        length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }

    # ActiveHashを利用するカラムのバリデーション（id: 1は「---」なので保存できないようにする）
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :shipping_day_id
    end

    validates :price, presence: true,
                      numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
end
