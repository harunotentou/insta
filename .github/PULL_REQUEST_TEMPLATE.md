## 概要

ユーザー登録、ログイン機能の実装

## 確認方法

1. Gem を追加したので `bundle install` を実行してください
2. モデルを追加したので `bundle exec rails db:migrate` を実行してください
3. bmdの導入のため、`yarn install`を実行してください

## コメント

MySQLの導入にてこずりました。
教えていただいた
https://qiita.com/kenkentarou/items/403e1029269b34a1b03e
を参考にdatabase.ymlは初期設定のまま使っているのですが
https://qiita.com/ryouya3948/items/b8a62b292132c2a9e9be
のようにユーザー登録をしてその値をdatabase.ymlに入れるべきなのでしょうか？

viewとcssはまんまコピペです。

rubobopはダウンロードした.rubocop.ymlを配置しただけでは
.rubocop.yml: Metrics/LineLength has the wrong namespace - should be Layout
Configuration file not found: /home/ec2-user/environment/insta/.rubocop_todo.yml
で動かず。。。
空のrubocop_todo.ymlを作ったら動いたのですがこれでよかったのでしょうか？

正直あまり理解せずにやっているのですが、宜しくお願い致します。
