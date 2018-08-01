class CartController < ApplicationController

	before_action :authenticate_user!, except: [:add_to_cart, :view_order]

  def add_to_cart
      line_item = LineItem.find_by(product_id: params[:product_id].to_i)

      #Check to see if the line item exist in the table already. If not, create the line_item
        if line_item.blank?
          line_item = LineItem.create(product_id: params[:product_id].to_i, quantity: params[:quantity].to_i)

      #if it does exist, modify the line item     
        else 
          old_quantity = line_item.quantity  
          line_item.update(quantity: old_quantity + params[:quantity].to_i)
        end  

        line_item.update(line_item_total: line_item.quantity * line_item.product.price)
        redirect_back(fallback_location: root_path)  



  	# line_item = LineItem.create(product_id: params[:product_id].to_i, quantity: params[:quantity].to_i)
  	# line_item.update(line_item_total: line_item.quantity * line_item.product.price)
  	# redirect_back(fallback_location: root_path)
	
  end

  def view_order
  	@line_items = LineItem.all
  end

  def checkout
  	line_items = LineItem.all
  	@order = Order.create(user_id: current_user.id, subtotal: 0)

  	line_items.each do |line_item|
  		line_item.product.update(quantity: (line_item.product.quantity - line_item.quantity))
  		@order.order_items[line_item.product_id] = line_item.quantity
  		@order.subtotal += line_item.line_item_total
  	end	
  		@order.save
  		@order.update(sales_tax: @order.subtotal * 0.08)
  		@order.update(grand_total: @order.sales_tax + @order.subtotal)
  
  		line_items.destroy_all

  end


  def edit_quantity
    line_item = LineItem.find(params[:id].to_i)
    line_item.update(quantity: params[:quantity].to_i)
    line_item.update(line_item_total: line_item.quantity * line_item.product.price)
    redirect_to view_order_path
  end  


  def delete_item
    line_item = LineItem.find(params[:id].to_i)
    line_item.delete
    redirect_to view_order_path
  end 

end
