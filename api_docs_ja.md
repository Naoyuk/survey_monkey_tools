# SurveyMonkey API
## Overview
### Getting Started
SurveyMonkey APIはRESTベースで、OAuth 2.0を採用し、レスポンスをJSONで返します。

APIを使用するには、SurveyMonkeyアカウントにドラフトアプリを登録する必要があります。  
ドラフトアプリの開発には90日間の猶予があり、その後、公開または非公開で展開する必要があります。  
公開アプリは、SurveyMonkeyアカウントを持っている人なら誰でも利用でき、当社の[App Directory](https://www.surveymonkey.com/apps/)で公開されます。  
自分自身や組織のためにアプリを作成する場合は、プライベートアプリを配布することができます。

#### Public Apps
公開アプリは、SurveyMonkeyユーザーに機能を拡張します。すべてのアプリは、SurveyMonkeyによる審査と承認が必要であり、当社のアプリディレクトリで公開する前に当社の利用規約を遵守する必要があります。

公開アプリは、スコープを使用してOAuth中にアプリのユーザーに許可を要求します。スコープによっては、アプリのユーザーが有料のSurveyMonkeyプランを持っている必要があります。

[App Directory](https://www.surveymonkey.com/apps/)で公開されている公開アプリは、当社のAPIに無制限にリクエストできます。  
公開アプリがドラフト（開発中）の場合は、ドラフトリクエストの制限に従います。

#### Private Apps
プライベートアプリはSurveyMonkeyによるレビューを受ける必要はありません。プライベートアプリは当社の利用規約に従います。  
プライベートアプリにはAPIリクエストの上限があり、上限を超える場合は購入することができます。

プライベートアプリのすべてのユーザーは、同じSurveyMonkeyチームに所属し、APIに直接アクセスできる有料のSurveyMonkeyプランを利用している必要があります。

#### アプリの登録
SurveyMonkeyのアカウントを持っていれば、誰でもアプリを登録することができます。  
登録すると、90日間自分のアカウントに対してクエリを実行するために使用できるアクセストークンを持つ下書きアプリが作成されます。  
他のSurveyMonkeyアカウントではドラフトアプリを認証することはできません。  
90日間の期間が終了する前に、アプリを公開または非公開のいずれかにデプロイし、必要に応じてアカウントをアップグレードする必要があります。

#### アプリのデプロイ
90日間のドラフト期間が終了する前に、アプリをデプロイする必要があります。  
アプリが無効になった場合は、アプリをデプロイするかヘルプセンターに連絡して延長を申請してください。

### スコープ
スコープを使用すると、アプリがユーザーに代わって特定のリソースにアクセスできるようになります。  
たとえば、**Create/Modify survey**では、アプリがユーザーのアカウントにSurveyを作成することができます。  
OAuthプロセスでは、アプリがアクセスを要求しているスコープへのアクセス許可をユーザーに求めます。

スコープによっては、アプリのユーザーがSurveyMonkeyの有料プランに加入している必要があります。  
Publicアプリで有料プランに関連付けられたスコープを使用している場合、必要なプランを持たずに認証を行おうとするアカウントは、処理を続行するためにアップグレードするよう求められます。  
リクエストヘッダには、ユーザーのプランで利用可能なスコープと、ユーザーがあなたのアプリに許可を与えたスコープが含まれています。

アプリの設定で、スコープを必須、任意、または不要に設定できます。  
OAuthプロセスを成功させるためには、すべての必須スコープがユーザーによって承認され、利用可能でなければなりません。

**Create/Modify Responses**と**Create/Modify Surveys**の2つのスコープは、公開アプリで使用するにはSurveyMonkeyの承認が必要です。公開アプリをデプロイしていて、これらのスコープを含むようにスコープ要件を変更したい場合は、ヘルプセンターまでご連絡いただき、お客様のアプリとユースケースについて詳しく教えていただく必要があります。

**Create/Modify Collectors**では、Webリンクコレクター以外のコレクターを作成するには、有料のSurveyMonkeyプランが必要です。

|スコープラベル|説明|スコープ名|Paid?|
|--|--|--|:--:|
|View Surveys|自分のSurveyと共有Surveyを見る|surveys_read|無料|
|Create/Modify Surveys|アカウントでSurveyを作成/編集する|surveys_write|無料|
|View Collectors|自分のSurveyおよび共有されたSurveyのコレクターを表示する|collectors_read|無料|
|Create/Modify Collectors|アカウントでSurveyのコレクターを作成/編集する|collectors_write|有料 (weblink collectorsを除く)|
|View Contacts|ContactとContactリストを表示する|contacts_read|無料|
|Create/Modify Contacts|アカウントのContactを作成/編集する|contacts_write|無料|
|View Responses|アカウント内のSurveyに回答があるかどうか、およびそのメタデータを表示する|responses_read|無料|
|View Response Details|回答、回答数、傾向を表示する|responses_read_detail|有料|
|Create/Modify Responses|自分のアカウントでSurveyの回答を作成/編集する|responses_write|有料|
|View Webhooks|アカウントに変更があった場合に通知を受け取るためのWebhookを表示する|webhooks_read|無料|
|Create/Modify Webhooks|Webhookを作成/編集する<br>アカウントに変更があった際には通知を受け取ることができる|webhooks_write|無料|
|View Users|ユーザー情報を見る|users_read|無料|
|View Teams|所属チームを見る|groups_read|有料|
|View Library Assets|Surveyテーマとテンプレートのライブラリを見る|library_read|無料|
|View Workgroups|チーム内のワークグループを見る|workgroups_read|有料|
|Create/Modify Workgroups|チーム内のワークグループの作成/編集する|workgroups_write|有料|
|View Workgroup Members|ワークグループのメンバーを表示する|workgroups_members_read|有料|
|Create/Modify Workgroup Members|ワークグループのメンバーを追加/削除する|workgroups_members_write|有料|
|View Roles|チームのメンバーに割り当て可能な役割を表示する|roles_read|有料|
|Create/Modify Roles|チームの役割の作成/編集する|roles_write|有料|
|View Workgroups Shared Resources|ワークグループ内で共有されているリソースを表示する|workgroups_shares_read|有料|
|Create/Modify Workgroups Shared Resources|ワークグループ内で共有されているリソースの追加/削除する|workgroups_shares_write|有料|

### リクエストとレスポンスの制限
ドラフトおよびプライベート・アプリはレート制限の対象となります：

- 1分間の最大リクエスト数: **120**  
- 1日の最大リクエスト数: **500**

APIの上限は、グリニッジ標準時(GMT)の毎日午前12時にリセットされます。  
30日以内に150%までの違反が3回まで許可されます。  
それを超えると、100%で制限を開始します。

アプリのレート制限、残りのリクエスト数、リセットまでの秒数をリクエストヘッダで返します。

さらに、Contactの作成やInvite Messageの送信のためにAPIに行われたリクエストは、送信およびContactの制限の対象となります。

##### 制限の増加
すべてのドラフトアプリとプライベートアプリは、当初120コール/分、500コール/日のリクエスト制限が適用されます。  
制限のしきい値を超える恐れがあり、一時的な増額が必要な場合は、ヘルプセンターにご連絡ください。  
SurveyMonkeyは5営業日以内にすべてのリクエストを確認します。  
料金の上限を引き上げるには追加料金がかかる場合があります。

##### 回答数制限
当社では、データベースの利用を公正に行うために、グローバルな回答制限も設けています。

##### プロパティの制限
特に指定のない限り、最大ページサイズは1000件です。
Surveyの最大サイズ1000質問、制限を超えたSurveyは413を返します。

### 認証
プライベートアプリを作成し、自分のSurveyMonkeyアカウントにのみアクセスする場合は、アプリの登録時に生成されたアクセストークンをアプリの設定の一部として使用できます。このトークンは`MY APPS`タブの`Settings`で取得します。

アプリが複数のSurveyMonkeyアカウントにアクセスする場合は、以下に説明するOAuth 2.0の3ステップフローを実装して、ユーザーがアプリでアカウントにアクセスすることを承認できるようにします。  
このフローでは、アプリが関連するSurveyMonkeyアカウントへのAPI呼び出しのたびに使用できる、長期間のアクセストークンを生成します。  
アクセストークンは、APIクレデンシャル（クライアントID）と組み合わせて使用した場合にのみアクセスを許可し、認証されたSurveyMonkeyアカウントのみにアクセスを許可することに注意してください。  
アプリはアクセスしたいSurveyMonkeyアカウントごとに追加のアクセストークンを取得する必要があります。

アプリに必須のスコープがある場合、ユーザーはすべてのスコープを承認する必要があり、アプリへのOAuthを成功させるには有料のSurveyMonkeyプランが必要になる場合があります。

#### OAuth 2.0 ワークフロー
##### Step1: ユーザーをSurveyMonkeyのOAuth認証ページに誘導する
アプリは、アクセスしたいSurveyMonkeyアカウントを持つユーザーに、`https://api.surveymonkey.com`で特別に作成したOAuthリンクを送信します。  
ユーザーに表示されるページでは、アプリを識別し、まだログインしていない場合はSurveyMonkeyにログインするよう求め、必要なスコープを承認するよう求めます。

OAuthリンクは、URLエンコードされたパラメータ(`redirect_uri`、`client_id`、`response_type`、`state`)を`https://api.surveymonkey.com/oauth/authorize`に設定する必要があります。

- `response_type`は常に`code`に設定されます。  
- `client_id`はアプリの登録時に取得した固有のSurveyMonkeyクライアントIDです。  
- `redirect_uri`はアプリに登録したOAuthリダイレクトURIをURLエンコードしたものです。([ここ](https://developer.surveymonkey.com/apps/)で見つけて編集できます)  
- `state`(推奨)リクエストに含まれる値で、トークンのレスポンスでも返されます。任意の内容の文字列を指定できます。クロスサイトリクエストフォージェリ攻撃を防ぐために、ランダムに生成されるユニークな値が一般的に使用されます。

##### Step2: ユーザーの承認によるShort-livedコードの生成
ユーザーがアクセスを承認するかどうかを選択すると、SurveyMonkeyはブラウザをリダイレクトURIに送信する302リダイレクトを生成します。  
あなたのアプリはそのコードを使って、期限切れ(5分)になる前に別のAPIリクエストを行う必要があります。  
そのリクエストで、受け取ったコードとクライアントシークレット、クライアントID、リダイレクトURIをお送りください。  
私たちはその情報をすべて確認します。  
問題がなければ、トークンを返します。

##### Step3：長期間のアクセストークンと交換する
以下のエンコードされたフォームフィールドを持つ、`https://api.surveymonkey.com/oauth/token`へのフォームエンコードされたHTTP POSTリクエストを作成します:  
- `client_id`
- `client_secret`
- `code`
- `redirect_uri`
- `grant_type`
`grant_type`は`authorization_code`に設定する。`client_secret`は[ここ](https://developer.surveymonkey.com/apps/)にあります。

成功すると、アクセストークンがPOSTリクエストのレスポンスボディにJSONとしてエンコードされて返されます。キーは`access_token`で、その値はHTTPヘッダーとして`Authorization: bearer YOUR_ACCESS_TOKEN`の形式でAPIに渡すことができます。ヘッダーの値は、**bearer**の後に半角スペース、そしてあなたのアクセストークンの順でなければなりません。

##### トークンの有効期限と失効
私たちのアクセストークンは将来失効する可能性があります。変更を加える前に、すべての開発者に警告します。

アクセストークンはユーザが失効させることがあります。  
この場合、APIリクエストの際に、`1`という値の`status`パラメータと、`Client revoked access grant`という値の`errmsg`パラメータを含むJSONエンコードされたレスポンスボディが返されます。このレスポンスを受け取った場合は、再度OAuthを完了させる必要があります。

##### アクセスURL
SurveyMonkeyアカウントのデータセンターによっては、APIアクセスURLが`https://api.surveymonkey.com`と異なる場合があります。  
EUのデータセンターのAPIは`https://api.eu.surveymonkey.com`で、カナダのデータセンターのAPIは`https://api.surveymonkey.ca`です。  
各SurveyMonkeyアカウントの正しいAPIアクセスURLは、トークン交換のコードのレスポンス本文で`access_url`の値として返されます。

##### アプリの認証解除
アプリの承認を取り消すには:
1. リンク先のSurveyMonkeyアカウントにログインします。
1. 右上のユーザー名のドロップダウンから`My Account`を選択します。
1. `Linked Account`までスクロールし、認証を解除するアプリの横にある`Remove`をクリックします。

### クイックスタートガイド(2つの共通ユースケース)
##### Surveyの結果のエクスポート
`surveys/{id}/responses/bulk`への呼び出しは選択されたすべての回答のIDを含む回答を返しますが、このユースケースではこれを選択された値と関連付けることが考えられます。次の例では、Surveyの結果をエクスポートし、回答を対応する回答値と関連付ける方法を説明します。

SurveyMonkeyアカウントの最初の1,000件のSurveyを`GET /surveys`で取得します。この呼び出しは、SurveyIDを含むリストリソースを返します。  
前のコールで取得したSurveyIDを使用して、`/surveys/{id}/details`をGETします。この呼び出しは、すべての質問IDと回答の選択肢ID、およびそれらに関連付けられた値を含むSurveyのデザインを返します。  
これらの値をキャッシュすることで、リクエストとレスポンスの上限を節約します。

同じSurveyIDを使用して、`/surveys/{id}/responses/bulk?per_page=100`へのGETでSurveyの最初の100件の回答を取得します。このエンドポイントは、各回答の質問IDと選択された回答または選択肢のIDを返します。  
これらを使用して、選択された回答IDを`/surveys/{id}/details`へのGETから返されたものに関連付け、質問の値を選択された回答に一致させることができます。  
`links.next`フィールドに返されたリソースURLを使用して、100件の回答の次のページを取得します。  
アカウント内のすべてのSurveyの結果をエクスポートするには、Step1で返されたすべてのSurveyIDを繰り返し、Step2~4を完了します。

単一のコレクターの結果をエクスポートするには、`/surveys/{id}/collectors`へのGETは、指定したSurveyに関連付けられたコレクターのIDリストを返します。`surveys/{id}/details`へのGETは、単一のコレクターからの回答を返します。

##### Invitation Messageの送信
次の例では、Invitationメールコレクターの作成と受信者リストへの送信について説明します。

SurveyMonkeyアカウントの最初の1,000件のSurveyを`GET /surveys`で取得します。この呼び出しは、SurveyIDを含むリストリソースを返します。
前のコールで取得したSurveyIDを使用して、`/surveys/{id}/collectors`にPOSTしてメールタイプのコレクターを作成します。
コレクター`/{id}/messages`にPOSTして、メールメッセージを作成し、フォーマットします。
`collectors/{id}/messages/{id}/recipients/bulk`にPOSTして、メッセージを受信する受信者をアップロードします。
`collectors/{id}/messages/{id}/send`へのPOSTでメッセージを送信します。

### ページネーション
リストリソースをリクエストするときは、`per_page=#`でページのサイズを設定し、`page=#`でどのページを返すかを指定します。つまり、`https://api.surveymonkey.com/v3/surveys?page=2&per_page=5`へのリクエストは、5つのSurveyの2ページ目を返します。

リストリソースへのどのリクエストも、利用可能な場合は以下のページ分割フィールドを返します：

|Name|Description|Type|
|-|-|-|
|per_page|ページあたりのリソース数|Integer|
|total|リソースの総数|Integer|
|page|どのページが返されるかを示す|Integer|
|links.self|現在のページのURL|String|
|links.prev|前のページのURL|String|
|links.next|次のページのURL|String|
|links.first|最初のページのURL|String|
|links.last|最終ページのURL|String|

### ヘッダー
APIは以下のカスタムヘッダーを返します

|Header|Description|
|-|-|
|X-OAuth-Scopes-Available|アプリを使用するユーザーが利用可能なスコープ|
|X-OAuth-Scopes-Granted|ユーザーがアプリにどのスコープを許可したか|
|X-Ratelimit-App-Global-Day-Limit|アプリが持つ1日あたりのリクエスト制限|
|X-Ratelimit-App-Global-Day-Remaining|アプリが1日の制限に達するまでの残りリクエスト数|
|X-Ratelimit-App-Global-Day-Reset|残りレート制限がリセットされるまでの秒数|
|X-Ratelimit-App-Global-Minute-Limit|アプリが持つ1分あたりのリクエスト制限|
|X-Ratelimit-App-Global-Minute-Remaining|アプリが1分あたりの制限に達するまでの残りリクエスト数|
|X-Ratelimit-App-Global-Minute-Reset|残りレート制限がリセットされるまでの秒数|

### データ型
APIは以下のデータ型を返します

|Data Type|Description|
|-|-|
|Integer|最大値 2147483647 の整数。特に指定がない限り、負の値は許されない。|
|String|文字列。|
|String-ENUM|定義済みの文字列値。値はフィールドごとに定義されています。|
|Boolean|真偽値。JSONでは、ネイティブのboolean型で表現されます。|
|Date string|日付は通常YYYY-MM-DDTHH:MM:SS+HH:MMの形式です。これからの逸脱はドキュメントに示されています。すべての日付文字列は暗黙的にUTCになります。|
|Phone number string|電話番号は+1XXXYYYZZZZの形式でなければなりません。|
|Hex string|HHHHまたは#HHHHHH（Hは16進数）の形式でなければならない。|
|Array|単純な値のリスト。JSONでは配列になります。|
|Object|名前と値のペアのコレクション。JSONではオブジェクトになる。|
|Null|ヌル値。JSONでは、これはネイティブのnull型として表現されます。|

### エラーコード
|Error Code|HTTP Status Code|Message|
|-|-|-|
|1000|400 Bad Request|指定された入力ではリクエストを処理できません。|
|1001|400 Bad Request|提供されたボディが適切なJSON文字列ではありません。|
|1002|400 Bad Request|指定されたボディ内のスキーマが無効です。|
|1003|400 Bad Request|無効な URL パラメータです。|
|1004|400 Bad Request|無効なリクエストヘッダです。|
|1005|402 Payment Required|この機能を利用するには、アカウントをアップグレードする必要があります。|
|1010|401 Authorization Error|認証トークンが提供されていません。|
|1011|401 Authorization Error|提供された認証トークンが無効です。|
|1012|401 Authorization Error|提供された認証トークンは期限切れです。|
|1013|401 Authorization Error|クライアントが提供された認証トークンへのアクセスを取り消しました。|
|1014|403 Permission Error|このリクエストはユーザーによって許可されていません。|
|1015|403 Permission Error|ユーザーは、このリクエストを行うために必要なプランを持っていません。|
|1016|403 Permission Error|ユーザーはリソースにアクセスする権限を持っていません。|
|1017|403 Permission Error|ユーザーがこのリソースのクォータ制限に達しました。|
|1018|403 Permission Error|このユーザーは、この地域のホストにアクセスする権限を持っていません。<br>アクセスURLを確認してください。|
|1020|404 Resource Not Found|要求されたリソースの取得にエラーが発生しました。|
|1025|409 Resource Conflict|競合のためリクエストを完了できません。リソースの設定を確認してください。|
|1026|409 Resource Conflict|要求されたリソースはすでに存在しています。|
|1030|413 Request Entity Too Large|要求されたエンティティが大きすぎるため、返せません。|
|1040|429 Rate Limit Reached|リクエストが多すぎます。|
|1050|500 Internal Server Error|そんなバナナ！リクエストを処理できませんでした。|
|1051|503 Internal Server Error|サービスにアクセスできません。後でもう一度お試しください。|
|1052|404 User Soft Deleted|あなたがこのリクエストを行っているユーザーは、論理削除されています。|
|1053|410 User Deleted|あなたがこのリクエストを行っているユーザーは物理削除されました。|
|1054|502 Bad Gateway Error|ネットワークがサーバーに接続できませんでした。|
|1055|504 Gateway Timeout|サービス接続がタイムアウトしました。後でもう一度お試しください。|
|1056|400 Bad Request|このメッセージの受信者が多すぎます。|
|1057|401 Authorization Error|認証トークンには権限がありません。|
|1058|403 Permission Error|このリクエストを実行する前に、ユーザーのEメールを確認する必要があります。|
|1059|400 Bad Request|メッセージを送信しようとしたが、受信者が指定されていません。|
|1060|400 Bad Request|埋め込みボディが保存されていません。|
|1061|405 Method Not Allowed|指定されたHTTPメソッドは許可されていません。|
|1062|400 Bad Request|このリソースに対するリクエストの上限を超えました。|
|1063|401 Bad Unauthorized|ユーザーはこのアクションを実行する権限がありません。<br>リクエストの詳細を確認し、もう一度やり直してください。|

### ヘルプとリソース
SurveyMonkeyは[Github](https://github.com/SurveyMonkey)でコード例を公開しています。  
SDKやサンプルを追加したい場合は、お知らせください。また、[ヘルプセンター](https://help.surveymonkey.com/contact/)によるサポートも提供しています。

## APIエンドポイント
Base URLs: `https://api.surveymonkey.com/v3`

### ユーザーとチーム
これらのエンドポイントを使用して、ユーザのアカウント情報、ユーザが所属しているチーム、チームのオーナーのアカウント情報、その他のメンバーの役割やチームへの招待を承認したかどうか(アクティブかどうか)などを取得します。

> 当社のAPIではグループという用語を使用していますが、SurveyMonkeyのUIではチームを使用しています。この2つの用語は同じ概念を指しています。チームについての詳細はヘルプセンターをご覧ください。

#### GET /users/me
`GET /users/me`

##### 利用可能なメソッド
- `HEAD`: リソースが利用可能かをチェックする
- `OPTIONS`: 利用可能なメソッドとオプションを返す
- `GET`: 現在のユーザーのアカウント詳細(プランも含む)を返す。公開アプリのユーザーは、**View Users**スコープのパラメータにアクセスする必要があります：

##### Responseスキーマ
Status Code: 200

|Name|Type|Description|
|-|-|-|
|id|string|User Id|
|username|string|Username|
|first_name|string|User’s first name|
|last_name|string|User’s last name|
|language|string|ISO 639-1コード(ユーザーアカウントの言語設定用)|
|email|string|ユーザーアカウントのメールアドレス|
|email_verified|boolean|ユーザーアカウントのメールアドレスが承認されているかどうかのブール値|
|account_type|string|ユーザーのSurveyMonkeyのプラン|
|date_created|string|ユーザーアカウントが作成された日付|
|date_last_login|string|ユーザーの最終ログイン日|
|question_types|object|ユーザーが利用可能な質問タイプのブール値|
|scopes|object|ユーザーが利用可能なスコープ、および付与されたスコープを含む|
|granted|[string]|OAuth時にユーザが承認したスコープをリストアップする|
|available|[string]|ユーザーが利用可能なスコープを一覧表示|
|sso_connections|[string]|サードパーティとのコネクション|
|features|object|ユーザーが利用できる機能。これらは文字列またはブーリアン値で識別される|
|href|string|このエンドポイントに関連するリンク|

#### GET /users/{user_id}/workgroups
`GET /users/{user_id}/workgroups`

#### GET /users/{user_id}/shared
`GET /users/{user_id}/shared`

#### GET /groups
`GET /groups`

#### GET /groups/{id}
`GET /groups/{id}`

#### GET /groups/{id}/activities
`GET /groups/{id}/activities`

#### GET /groups/{id}/activities/{activity_type}
`GET /groups/{id}/activities/{activity_type}`

#### GET /groups/{group_id}/members
`GET /groups/{group_id}/members`

#### GET /groups/{group_id}/members/{member_id}
`GET /groups/{group_id}/members/{member_id}`

### Surveyページと質問

### 質問バンク

### Surveyフォルダ

### 翻訳と多言語対応

### コンタクトとコンタクトリスト

### Survey Responses

### Responseカウントと傾向

### Webhooks

### ベンチマーク

### 組織

### エラー
