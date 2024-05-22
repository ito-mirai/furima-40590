const pay = () => {

  // payjpインスタンスの生成
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)// PAY.JPテスト公開鍵

  // フォームを生成する前準備としてelementsインスタンスを生成
  const elements = payjp.elements();

  // フォームを生成
  const numberElement = elements.create('cardNumber');  // カード番号
  const expiryElement = elements.create('cardExpiry');  // 有効期限
  const cvcElement = elements.create('cardCvc');  // CVC

  // 指定した要素と生成したフォームを置き換える
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  // フォームオブジェクトを取得
  const form = document.getElementById('charge-form')
  
  // 送信ボタン押下でイベント発火
  form.addEventListener("submit", (e) => {

    // カード情報のトークンを戻り値として取得するメソッド
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        // トークンオブジェクトを代入
        const token = response.id;

        // 取得したトークンをサーバーサイドに送付するためトークンをフォーム情報に追加する
        // フォームオブジェクトを取得
        const renderDom = document.getElementById("charge-form");

        // トークンをinput要素の形に加工（情報は非表示にする）
        const tokenObj = `<input value=${token} name='token' type="hidden">`;

        // フォームオブジェクトに加工したトークンを追加
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // フォームに存在するクレジットカード情報を削除
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
    // railsにおけるフォーム送信処理をキャンセル
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
// window.addEventListener("turbo:render", pay);