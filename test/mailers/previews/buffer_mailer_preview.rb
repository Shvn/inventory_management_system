# Preview all emails at http://localhost:3000/rails/mailers/buffer_mailer
class BufferMailerPreview < ActionMailer::Preview
  def low_quantity_email
    admin = User.is_admin.first
    @item = Item.take
    @priority = @item.calculate_priority
    BufferMailer.low_quantity_email(admin, @item, @priority)
  end
end
