class ApplicationMailer < ActionMailer::Base
  add_template_helper BooksHelper
  add_template_helper LineItemsHelper

  default from: "from@example.com"
  layout "mailer"
end
