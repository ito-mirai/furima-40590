# README

# テーブル設計

## users　テーブル

| Column             | Type   | Options     | Remarks |
| ------------------ | ------ | ----------- | ------- |
| nickname           | string | null: false | ユーザー名 |
| email              | string | null: false | メールアドレス |
| encrypted_password | string | null: false | パスワード |
| f_name             | string | null: false | 性 |
| p_name             | string | null: false | 名 |
| f_name_kana        | string | null: false | 性（カナ） |
| p_name_kana        | string | null: false | 名（カナ） |
| birthday           | date   | null: false | 生年月日 |
### Association
- has_many :items
- has_many :purchases


## items テーブル

| Column             | Type       | Options                        | Remarks |
| ------------------ | ---------- | ------------------------------ | ------- |
| name               | string     | null: false                    | 商品名 |
| text               | text       | null: false                    | 商品説明 |
| category           | integer    | null: false                    | 商品カテゴリー（プルダウン） |
| quality            | integer    | null: false                    | 商品の状態（プルダウン） |
| ship_load          | integer    | null: false                    | 配送料の負担（プルダウン） |
| ship_region        | integer    | null: false                    | 配送元の地域（プルダウン） |
| ship_days          | integer    | null: false                    | 発送までの日数（プルダウン） |
| price              | integer    | null: false                    | 価格 |
| user               | references | null: false, foreign_key: true | |
### Association
- belongs_to :user
- has_one :purchase


## purchases テーブル

| Column             | Type       | Options                        | Remarks |
| ------------------ | ---------- | ------------------------------ | ------- |
| user               | references | null: false, foreign_key: true | |
| item               | references | null: false, foreign_key: true | |
### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery


## deliveries テーブル

| Column             | Type       | Options                        | Remarks |
| ------------------ | ---------- | ------------------------------ | ------- |
| post_code          | string     | null: false                    | 郵便番号 |
| prefectures        | integer    | null: false                    | 都道府県（プルダウン） |
| municipalities     | string     | null: false                    | 市区町村 |
| address            | string     | null: false                    | 番地 |
| building           | string     |                                | 建物名 |
| telephone          | integer    | null: false                    | 電話番号 |
| purchase           | references | null: false, foreign_key: true | |
### Association
- belongs_to :purchase