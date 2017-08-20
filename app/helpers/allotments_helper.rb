module AllotmentsHelper
  def increment_quantity
    @item.update(quantity: @item.quantity + 1)
  end

  def decrement_quantity
    @item.update(quantity: @item.quantity - 1)
  end

  def check_quantity
    notify_admins if @item.buffer_quantity_reached?
  end

  def notify_admins
    @admins = User.type_admin
    @priority = @item.calculate_priority
    @admins.each do |admin|
      BufferMailer.low_quantity_email(admin, @item, @priority).deliver_now
    end
  end
end
