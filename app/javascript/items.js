function price_calculation (){

  //各HTML要素を取得
  const item_price = document.getElementById("item-price")
  const add_tax_price = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")
  
  //キーが入力されたとき、"item-price"に対して……
  item_price.addEventListener('keyup', () => {
    const price = parseFloat(item_price.value)  //入力された"文字列"を"数値"に変換

    if (price >= 0) { //数値が0以上のときだけ計算処理を行う
      //販売手数料と販売利益を計算(Math.floorで小数点以下を切り捨て)
      let commission_value = Math.floor(price * 0.1)
      let profit_value = price - Math.floor(commission_value)
      
      //HTML要素の書き換え（ついでにカンマを挿入）
      add_tax_price.innerHTML = commission_value.toLocaleString()
      profit.innerHTML = profit_value.toLocaleString()

    } else {  //入力がない場合や数値マイナスでは何も表示しない
      add_tax_price.innerHTML = ""
      profit.innerHTML = ""
    }
  })
}

window.addEventListener('turbo:load', price_calculation);