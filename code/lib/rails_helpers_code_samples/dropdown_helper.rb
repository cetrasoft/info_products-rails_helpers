module RailsHelpersCodeSamples
  module DropdownHelper

    def dropdown(&block)
      dropdown = Dropdown.new(self)
      capture(dropdown, &block)
      dropdown.html
    end

    private

    class Dropdown
      delegate :content_tag, :link_to, :safe_join, :capture, to: :context

      def initialize(context)
        @context = context
        @items = []
      end

      def add_item(name, url)
        items << [name, url]
      end

      def html
        parts = [trigger, list]
        content_tag(:div, safe_join(parts), class: "dropdown")
      end

      private

      attr_accessor :context, :items

      def trigger
        link_to("javascript:void(0)", data: { toggle: "dropdown" }) do
          "Dropdown Trigger".html_safe + content_tag(:span, nil, class: "caret")
        end
      end

      def list
        content_tag(:ul, safe_join(_items), class: "dropdown-menu")
      end

      def _items
        items.map { |name, url| content_tag(:li, link_to(name, url)) }
      end
    end

  end
end
