tasks テーブル
| column | type |
|-------------|--------|
| task_name | string |
| task_detail | string |

heroku へのデプロイ手順

- heroku に登録してログイン可能な状態にする
- herokuCLI をインストールする
- heroku にログインする
- ruby3 系を使用している場合以下を gem に記述して bundle
  gem 'net-smtp'
  gem 'net-imap'
  gem 'net-pop'
- heroku create し heroku にアプリを作成する
- heroku にアプリケーションをコンパイルする為にビルドパックを追加
- heroku に node.js のビルドパックを追加
- heroku にデプロイする。ブランチが master でない場合は git push heroku master:step2 などとする
