module RailsHelpersCodeSamples
  module DescriptionListHelper

    def description_list_pair(term, definition)
      tags = [
        content_tag(:dt, term),
        content_tag(:dd, definition.presence || '-')
      ]
      safe_join(tags)
    end

    def description_list_pair_for(record, attribute)
      term        = attribute.to_s.titleize
      definition  = record.send(attribute)

      description_list_pair(term, definition)
    end

    def description_list_for(record, attributes, horizontal = false)
      style = horizontal ? 'dl-horizontal' : ''
      pairs = attributes.map { |a| description_list_pair_for(record, a) }

      content_tag(:dl, safe_join(pairs), class: style)
    end
  end
end