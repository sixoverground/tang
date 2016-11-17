module Tang
  module ApplicationHelper

    def created_date(date)
      date.strftime('%Y/%m/%d')
    end

    def created_datetime(date)
      date.strftime('%Y/%m/%d %H:%M')
    end

    def plan_cost(plan)
      "#{number_to_currency(plan.amount / 100)}/#{plan.interval}"
    end

    def current_customer
      @current_customer
    end

    def coupon_off(coupon)
      if coupon.percent_off.present?
        "#{coupon.percent_off}\% off"
      elsif coupon.amount_off.present?
        "#{number_to_currency(coupon.amount_off)} off"
      end
    end

    def discount(amount, coupon)
      puts "DISCOUNT: #{amount}, #{coupon.percent_off}"
      subtotal = amount
      if coupon.percent_off.present?
        subtotal = amount.to_f * (coupon.percent_off.to_f / 100)
      elsif coupon.amount_off.present?
        subtotal = coupon.amount_off
      end
      puts "SUBTOTAL: #{subtotal}"
      return number_to_currency(subtotal.to_f / -100)
    end
  end
end
