# Teachable Concept: using inner clas to represent the structure (parts of the HTML)

# Decide: show the BAD way first? V0

module RailsHelpersCodeSamples
  module ModalV1Helper
    
    def modal_v1(id, title, content)
      Modal.new(self, id, title, content).html
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
        content_tag(:button, type: 'button', class: 'close', 
                    data: { dismiss: 'modal' }, 
                    aria_label: 'Close') do
          content_tag(:span, '&times;'.html_safe, aria_hidden: true)
        end
      end

      def title
        content_tag(:h4, @title, class: 'modal-title')
      end
    end
  end
end