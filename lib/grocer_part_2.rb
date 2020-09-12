require_relative './part_1_solution.rb'
require 'pry'
def apply_coupons(cart, coupons)
counter = 0
while counter < coupons.length
  cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
  coupon_item_name = "#{coupons[counter][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
  if cart_item && cart_item[:count] >= coupons[counter][:num]
    if cart_item_with_coupon
      cart_item_with_coupon[:count] += coupons[counter][:num]
      cart_item[:count] -= coupons[counter][:num]
    else
      cart_item_with_coupon = {
        :item => coupon_item_name,
        :price => coupons[counter][:cost] / coupons[counter][:num],
        :clearance => cart_item[:clearance],
        :count => coupons[counter][:num]
      }
      cart.push(cart_item_with_coupon)
      cart_item[:count] -= coupons[counter][:num]
    end
  end
counter += 1
end
cart
end


def apply_clearance(cart)
discount = 0.8
counter = 0
while counter < cart.length
  if cart[counter][:clearance]
    cart[counter][:price] = (cart[counter][:price] * discount).round(2)
  end
counter += 1
end
cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupon_cart)
  total = 0
  counter = 0
  while counter < final_cart.length
  total += (final_cart[counter][:price] * final_cart[counter][:count])
  counter += 1
  end
  if total <= 100.00
    return total
  else total = total * 0.9
    total
  end
end

