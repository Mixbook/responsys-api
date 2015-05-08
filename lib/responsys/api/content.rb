module Responsys
  module Api
    module Content
      def set_document_content(interact_object, content)
        api_method(:set_document_content, { document: interact_object.to_api, content: content })
      end
    end
  end
end