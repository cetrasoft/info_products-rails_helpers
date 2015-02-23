# Teachable Concept: Calling methods on the helper within the content block

module RailsHelpersCodeSamples
  module ModalV3Helper

    def modal_v3(id, title, &block)
      modal = Modal.new(self, id, title, &block)
      capture(modal, &block)
      modal.html
    end

    private

    class Modal

      delegate :content_tag, :safe_join, :capture, to: :context

      def initialize(context, id, title)
        @context  = context
        @id       = id
        @title    = title
      end

      def html
        parts = [header, _body, _footer]

        content_tag(:div, class: 'modal', id: @id) do
          content_tag(:div, class: 'modal-dialog') do
            content_tag(:div, safe_join(parts), class: 'modal-content')
          end
        end
      end

      def body(&block)
        @body_content = capture(&block)
      end

      def footer(&block)
        @footer_content = capture(&block)
      end

      private

      attr_accessor :context

      def _footer
        content_tag(:div, @footer_content, class: 'modal-footer')
      end

      def _body
        content_tag(:div, @body_content, class: 'modal-body')
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