module RailsHelpersCodeSamples
  module ModalV2Helper

    def modal_v2(id, title, &block)
      Modal.new(self, id, title, capture(&block)).html
    end

    private

    class Modal

      delegate :content_tag, :safe_join, to: :context

      def initialize(context, id, title, content)
        @context  = context
        @id       = id
        @title    = title
        @content  = content
      end

      def html
        parts = [header, body]

        content_tag(:div, class: 'modal', id: @id) do
          content_tag(:div, class: 'modal-dialog') do
            content_tag(:div, safe_join(parts), class: 'modal-content')
          end
        end
      end

      private

      attr_accessor :context

      def body
        content_tag(:div, @content, class: 'modal-body')
      end

      def header
        tags = [close_button, title]

        content_tag(:div, safe_join(tags), class: 'modal-header')
      end

      def close_button
        options = {
          type: 'button', 
          class: 'close', 
          data: { dismiss: 'modal' }, 
          aria_label: 'Close'
        }

        # NOTE: should we remove all the TBS aria bullshit?
        content_tag(:button, options) do
          content_tag(:span, '&times;'.html_safe, aria_hidden: true)
        end
      end

      def title
        content_tag(:h4, @title, class: 'modal-title')
      end
    end
  end
end