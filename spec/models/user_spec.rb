require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録' do
    describe '正常系' do
      it '必要な情報を適切に入力している。' do
        expect(@user).to be_valid
      end
    end
    describe '異常系' do
      it 'ニックネームが必須であること。' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが必須であること。' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること。' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'メールアドレスは、@を含む必要があること。' do
        @user.email = "emailemail"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'パスワードが必須であること。' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードは、129文字以下での入力が必須であること' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = "aaaaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
        @user.password_confirmation = "1234abcd"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'お名前(全角)は、名字が必須であること。' do
        @user.f_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("F name can't be blank")
      end
      it 'お名前(全角)は、名前が必須であること。' do
        @user.p_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("P name can't be blank")
      end
      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.f_name = "name"
        @user.valid?
        expect(@user.errors.full_messages).to include("F name is invalid")
      end
      it 'お名前カナ(全角)は、名字が必須であること。' do
        @user.f_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("F name kana can't be blank")
      end
      it 'お名前カナ(全角)は、名前が必須であること。' do
        @user.p_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("P name kana can't be blank")
      end
      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
        @user.f_name_kana = "katakana"
        @user.valid?
        expect(@user.errors.full_messages).to include("F name kana is invalid")
      end
      it '生年月日が必須であること。' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end

end