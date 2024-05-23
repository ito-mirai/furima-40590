class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :Purchases

  validates :nickname, presence: true
  validates :birthday, presence: true

  # 全角かなカナ漢字に制約
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :f_name
    validates :p_name
  end
  # 全角カナに制約
  with_options presence: true, format: { with: /\A[ァ-ヶ一]+\z/ } do
    validates :f_name_kana
    validates :p_name_kana
  end
  # passwordを英数字混合に制約
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX
end
