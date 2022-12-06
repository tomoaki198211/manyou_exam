tasks テーブル
| column | type |
|-------------|--------|
| task_name | string |
| task_detail | string |

heroku へのデプロイ手順

## 前準備

- heroku に登録してログイン可能な状態にする
- herokuCLI をインストールする
- heroku にログインする
- ruby3 系を使用している場合以下を gem に記述して bundle
  gem 'net-smtp'
  gem 'net-imap'
  gem 'net-pop'

## heroku へデプロイ

- heroku create し heroku にアプリを作成する
- heroku にアプリケーションをコンパイルする為にビルドパックを追加
- heroku に node.js のビルドパックを追加
- heroku にデプロイする。ブランチが master でない場合は git push heroku master:step2 などとする
- stack のバージョンを下げる必要がある場合、下記のコマンドで切り替える。
  heroku stack:set heroku-20
- Failed to install gems via Bundler.が出た場合下のコマンドで対応
  bundle lock --add-platform x86_64-linux
- Precompiling assets failed.が出た場合
- openssl-legacy-provider オプションをつけるか node の ver を指定する
- heroku run rails db:migrate でデータベースを使える状態にする。

## heroku 　パイプライン作成

- heroku のアプリケーションを選択し「deploy」のタブから
  github を選び、connect、マスターブランチを選択し連携する。
