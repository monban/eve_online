require 'json'

module EveOnline
  module Sovereignty
    class Campaigns < Base
      API_ENDPOINT = 'https://public-crest.eveonline.com/sovereignty/campaigns/'
      def initialize
        @parser = JSON
      end
      def result
        @result ||= response.fetch('items')
      end
      def url
        API_ENDPOINT
      end
    end
  end
end

