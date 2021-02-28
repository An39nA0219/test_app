UserがPostを作って共有するだけのアプリ。
イメージはTwitter。

users#createはログイン外で行う。

user_sessions#createでログイン。

users#index,show,posts#index,show,createはログイン内で行う。

users#update,destroy,posts#update,destroyはログインユーザーのみ可能。
