class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  # has_many :orders # orderテーブル作成後にコメントを外します

  validate :password_complexity

  validates :nickname, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/ } do
    validates :last_name_kana
    validates :first_name_kana
  end

  validates :birth_date, presence: true

  private

  def password_complexity
    # passwordがnilまたは空文字の場合は、deviseのpresence validationに任せる
    return if password.blank?

    # 正規表現で「半角の英字」と「半角の数字」が両方含まれているかを確認
    return if password.match?(/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i)

    errors.add(:password, 'は半角英数字混合で入力してください')
  end
end
