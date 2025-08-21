require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    let(:user) { FactoryBot.create(:user) }
    let(:item) { FactoryBot.create(:item) }
    let(:order_address) { FactoryBot.build(:order_address, user_id: user.id, item_id: item.id) }

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        order_address.building_name = ''
        expect(order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できないこと' do
        order_address.token = nil
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空だと保存できないこと' do
        order_address.postal_code = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        order_address.postal_code = '1234567'
        order_address.valid?
        expect(order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idが1(---)では保存できないこと' do
        order_address.prefecture_id = 1
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        order_address.city = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        order_address.address = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        order_address.phone_number = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下だと保存できないこと' do
        order_address.phone_number = '090123456'
        order_address.valid?
        expect(order_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが12桁以上だと保存できないこと' do
        order_address.phone_number = '090123456789'
        order_address.valid?
        expect(order_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberに半角数字以外が含まれている場合は保存できないこと' do
        order_address.phone_number = '090-1234-5678'
        order_address.valid?
        expect(order_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'userが紐付いていないと保存できないこと' do
        order_address.user_id = nil
        order_address.valid?
        expect(order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        order_address.item_id = nil
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
