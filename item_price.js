const calculatePrice = () => {
  // 価格入力フォームの要素を取得
  const priceInput = document.getElementById("item-price");
  // 要素が存在しない場合は、以降の処理を実行しない
  if (!priceInput) { return; }

  // 価格入力フォームでキー入力があるたびにイベントが発火する
  priceInput.addEventListener("input", () => {
    // 入力された価格の値を取得
    const inputValue = priceInput.value;

    // 販売手数料と販売利益を表示する要素を取得
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    // 販売手数料を計算（入力値の10%）し、小数点以下を切り捨て
    const tax = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = tax;

    // 販売利益を計算（入力値 - 販売手数料）
    const profit = inputValue - tax;
    profitDom.innerHTML = profit;
  });
};

// ページの読み込みとTurbolinks/Turboのページ遷移の両方に対応
window.addEventListener("turbo:load", calculatePrice);
window.addEventListener("DOMContentLoaded", calculatePrice);

