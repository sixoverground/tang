module Tang
  module ApplicationHelper

    # def created_date(date)
    #   date.strftime('%Y/%m/%d')
    # end

    def created_datetime(date)
      date.strftime('%Y/%m/%d %H:%M')
    end

    def plan_cost(plan)
      "#{number_to_currency(plan.amount / 100)}/#{plan.interval}"
    end

    def customer_plan_cost(customer, plan)
      amount_off = 0
      if customer.coupon.present?
        logger.debug "customer coupon present"
        if customer.coupon.percent_off.present?
          amount_off = (customer.coupon.percent_off.to_f / 100.0) * plan.amount.to_f
        elsif customer.coupon.amount_off.present?
          amount_off = customer.coupon.amount_off
        end
      end
      amount = plan.amount - amount_off
      "#{number_to_currency(amount / 100)}/#{plan.interval}"
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
      subtotal = amount
      if coupon.percent_off.present?
        subtotal = amount.to_f * (coupon.percent_off.to_f / 100)
      elsif coupon.amount_off.present?
        subtotal = coupon.amount_off
      end
      return number_to_currency(subtotal.to_f / -100)
    end
  end
end
