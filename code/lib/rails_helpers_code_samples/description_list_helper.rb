# Teachable Concept: 
# Separate domain/project-specific helpers from generic ones. 
# Build the former on top of the latter
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

  end
end