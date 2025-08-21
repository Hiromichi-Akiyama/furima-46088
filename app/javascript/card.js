const pay = () => {
  const form = document.getElementById('charge-form');
  // フォームが存在しない場合は、コンソールにエラーを出力して処理を終了
  if (!form) {
    console.error('ERROR: Form with id "charge-form" not found. The payment process cannot be initialized.');
    return;
  }
  if (typeof gon === 'undefined' || !gon.public_key) {
    console.error('ERROR: gon.public_key is not set. Make sure to set it in your controller.');
    return;
  }
  if (typeof Payjp === 'undefined') {
    console.error('ERROR: Payjp is not defined. Make sure to include the Pay.jp V2 script in your layout file.');
    return;
  }

  // イベントの二重登録を防止
  if (form.dataset.payjpInitialized) return;
  form.dataset.payjpInitialized = "true";

  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    // 送信ボタンを無効化して二重送信を防ぐ
    const submitButton = form.querySelector('input[type="submit"]');
    submitButton.disabled = true;

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // トークン作成に失敗（未入力/不正）した場合はそのまま送信し、
        // サーバー側のバリデーションでエラー（Token can't be blank など）を表示させる
        form.submit();
      } else {
        const token = response.id;

        // 既存のトークンがあれば削除
        const existingToken = form.querySelector('input[name="token"]');
        if (existingToken) {
          existingToken.remove();
        }

        // 新しいトークンをフォームに追加
        const tokenInput = document.createElement('input');
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'token');
        tokenInput.setAttribute('value', token);
        form.appendChild(tokenInput);

        // カード情報をクリア
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        form.submit();
      }
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);