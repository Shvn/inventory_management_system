class BufferMailer < ApplicationMailer
  default from: 'no-reply-buffer@ims.com'

  def low_quantity_email(admin, item, priority)
    @item = item
    @priority = priority
    mail(
      to: admin.email,
      subject: "Low quantity of #{@item.name}"
    )
  end
end
