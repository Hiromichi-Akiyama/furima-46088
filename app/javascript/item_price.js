// app/javascript/item_price.js
const calculatePrice = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  // すでにバインド済みなら二重登録しない
  if (priceInput.dataset.bound === "true") return;
  priceInput.dataset.bound = "true";

  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  const update = () => {
    const val = Number(priceInput.value);
    if (!Number.isFinite(val) || val === 0) {
      addTaxDom.textContent = "";
      profitDom.textContent = "";
      return;
    }
    const fee = Math.floor(val * 0.1);
    const profit = val - fee;
    addTaxDom.textContent = fee.toLocaleString();
    profitDom.textContent = profit.toLocaleString();
  };

  // 初回表示時も再計算（エラーで再描画されたとき、既に値が入っている場合に対応）
  update();
  priceInput.addEventListener("input", update);
};

// 初回読み込み / Turbo遷移 / 422での再描画 すべてに対応
window.addEventListener("DOMContentLoaded", calculatePrice);
window.addEventListener("turbo:load",     calculatePrice);
window.addEventListener("turbo:render",   calculatePrice); // ← 追加