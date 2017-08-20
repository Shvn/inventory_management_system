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
end
