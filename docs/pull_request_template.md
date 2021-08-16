## やったこと

### 基本課題

- [x] `query{viewer{name}}` で HTTP ヘッダー `X-User-Name` のユーザーを返す
- [ ] `query{pickupLocations{id,name}}` ですべての受け取り場所を返す
- [ ] `query{products{id,name,description,price,imageUrl}}` ですべての商品を返す
  - [ ] `imageUrl` の URL で商品画像を返す
- [ ] `query($id:ID!){product(id:$id){id}}` で引数の商品IDの商品を返す
- [ ] Mutation `updatePickupLocation` の実行時にユーザーのデフォルトの受け取り場所を変更する
- [ ] Mutation `createOrder` の実行時に以下を行う
  - [ ] 内部で注文データを作成する
  - [ ] minifinancier の rpc `Charge` を呼ぶ

### 応用課題

- [ ] 商品の name と description を対象とした検索機能
- [ ] 商品カテゴリ
- [ ] 注文作成時の引数のバリデーション
- [ ] 注文のキャンセル
- [ ] 注文の返金（minifinancier への返金 rpc の追加）
- [ ] その他（この下に内容を具体的に書いてください）

## 工夫したこと


## 難しかったこと
