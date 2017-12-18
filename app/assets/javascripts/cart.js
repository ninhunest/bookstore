$(document).ready(function(){
  $('body').on('change','.item-quantity',function(){
    // update item total
    var item_id = $(this)[0].id;
    var quantity = $(this).context.value;
    var item_price = format_price($('#item-price-' + item_id).html(), 0, -4);
    var item_discount = Number($('#item-discount-' + item_id).html().trim()
      .slice(0, -1));
    var item_total = (item_price - item_price * item_discount / 100) * quantity;

    $('#item-total-' + item_id).html(to_vnd(item_total));

    // update item subtotal
    var sub_total = 0;
    var total_arr = $('.item-total-price');

    for (k = 0; k < total_arr.length; k++) {
      var price = total_arr[k].textContent;
      var int_price = format_price(price, 0, -4);
      sub_total += int_price;

    }
    $('#sub-total').html(to_vnd(sub_total));

    // Ajax update line item quantity
    $.ajax({
      type: 'POST',
      url: '/line_items/update_quantity',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token',
        $('meta[name="csrf-token"]').attr('content'))},
      data: {
        id: item_id,
        quantity: quantity
      },
      contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    });
  });

  function format_price(price_string, start_slice, end_slice){
    var split_arr = price_string.trim().slice(start_slice, end_slice).split('.');
    var item_price = "";

    for (i = 0; i < split_arr.length; i++) {
      item_price += split_arr[i];
    }

    return Number(item_price);
  }

  function to_vnd(price){
    var string_price = accounting.formatMoney(price, {precision: 0,
      thousand: ".", symbol: "vnđ", format: "%v %s"});

    return string_price;
  }
})

