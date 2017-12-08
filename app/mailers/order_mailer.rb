class OrderMailer < ApplicationMailer
  default from: "khactoan96@gmail.com"

  def send_order_info custom_email, custom_name, custom_cart
    @custom_name = custom_name
    @custom_cart = Cart.find_by id: custom_cart

    mail to: custom_email, subject: t("order_notice")
  end
end
