class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  #↓正規表現で制約をかけているためおそらくいらない？
  # validates :f_name, presence: true
  # validates :p_name, presence: true
  # validates :f_name_kana, presence: true
  # validates :p_name_kana, presence: true
  validates :birthday, presence: true

    #全角かなカナ漢字に制約
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :f_name
    validates :p_name
  end
    #全角カナに制約
  with_options presence: true, format: { with: /\A[ァ-ヶ一]+\z/, message: 'カタカナを使用してください' } do
    validates :f_name_kana
    validates :p_name_kana
  end

    #passwordを英数字混合に制約
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
end
