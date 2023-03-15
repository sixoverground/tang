require 'will_paginate/view_helpers/action_view'

module Tang
  module ApplicationHelper
    def created_datetime(date)
      date.strftime('%Y/%m/%d %H:%M')
    end

    def plan_cost(plan)
      "#{number_to_currency(plan.amount.to_f / 100.0)}/#{plan.interval}"
    end

    def customer_plan_cost(customer, plan)
      amount_off = 0
      if customer.has_subscription_coupon?
        amount_off = customer.subscription.discount_for_plan(plan)
      elsif customer.coupon.present?
        amount_off = customer.discount_for_plan(plan)
      end
      amount = plan.amount - amount_off
      "#{number_to_currency(amount.to_f / 100.0)}/#{plan.interval}"
    end

    def current_customer
      @current_customer
    end

    def coupon_off(coupon)
      if coupon.percent_off.present?
        "#{coupon.percent_off}\% off"
      elsif coupon.amount_off.present?
        "#{number_to_currency(coupon.amount_off.to_f / 100.0)} off"
      end
    end

    def will_paginate(collection_or_options = nil, options = {})
      options, collection_or_options = collection_or_options, nil if collection_or_options.is_a? Hash
      options = options.merge renderer: BootstrapLinkRenderer unless options[:renderer]
      super(*[collection_or_options, options].compact)
    end

    class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer
      ELLIPSIS = '&hellip;'.freeze

      def to_html
        list_items = pagination.map do |item|
          case item
          when Integer
            page_number(item)
          else
            send(item)
          end
        end.join(@options[:link_separator])
        tag('ul', list_items, class: ul_class)
      end

      def container_attributes
        super.except(*[:link_options])
      end

      protected

      def page_number(page)
        link_options = @options[:link_options] || {}

        if page == current_page
          tag(
            'li',
            tag('span', "#{page} <span class=\"sr-only\">(current)</span>", class: 'page-link'),
            class: 'page-item active'
          )
        else
          tag('li', link(page, page, link_options.merge(rel: rel_value(page), class: 'page-link')), class: 'page-item')
        end
      end

      def previous_or_next_page(page, text, classname)
        link_options = @options[:link_options] || {}
        if page
          tag('li', link(text, page, link_options.merge(class: 'page-link')), class: format('%s page-item', classname))
        else
          tag('li', tag('span', text, class: 'page-link'), class: format('%s page-item disabled', classname))
        end
      end

      def gap
        tag('li', tag('span', ELLIPSIS), class: 'page-item disabled')
      end

      def previous_page
        @options[:previous_label] = '<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span>'
        num = @collection.current_page > 1 && (@collection.current_page - 1)
        previous_or_next_page(num, @options[:previous_label], 'prev')
      end

      def next_page
        @options[:next_label] = '<span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span>'
        num = @collection.current_page < @collection.total_pages && (@collection.current_page + 1)
        previous_or_next_page(num, @options[:next_label], 'next')
      end

      def ul_class
        [@options[:class]].compact.join(' ')
      end
    end
  end
end
