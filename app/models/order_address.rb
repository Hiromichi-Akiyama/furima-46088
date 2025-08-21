class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :city
    validates :address

    # フォーマット/値のチェックと存在チェックを同時に行う
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  def save
    # データベースへの保存処理をトランザクションで囲む
    ActiveRecord::Base.transaction do
      # 注文情報を保存し、変数orderに代入する
      order = Order.create!(user_id: user_id, item_id: item_id)
      # 住所を保存する
      # order_idには、今作成したorderのidを指定する
      Address.create!(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building_name: building_name,
        phone_number: phone_number,
        order_id: order.id
      )
    end
  end
end
