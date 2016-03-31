module EveOnline
  module Account
    # https://eveonline-third-party-documentation.readthedocs.org/en/latest/xmlapi/account_apikeyinfo/
    class ApiKeyInfo < XmlApi
      API_ENDPOINT = 'https://api.eveonline.com/account/APIKeyInfo.xml.aspx'.freeze

      attr_reader :key_id, :v_code

      def initialize(key_id, v_code)
        super()
        @key_id = key_id
        @v_code = v_code
      end

      def characters
        case row
        when Hash
          [EveOnline::Character.new(row)]
        when Array
          output = []
          row.each do |character|
            output << EveOnline::Character.new(character)
          end
          output
        else
          raise ArgumentError
        end
      end

      def row
        @row ||= rowset.fetch('row')
      end

      def rowset
        @rowset ||= key.fetch('rowset')
      end

      def expires
        @expires ||= ActiveSupport::TimeZone['UTC'].parse(key.fetch('@expires'))
      end

      def type
        @type ||= key.fetch('@type')
      end

      def access_mask
        @access_mask ||= key.fetch('@accessMask').to_i
      end

      def key
        @key ||= result.fetch('key')
      end

      def url
        "#{ API_ENDPOINT }?keyID=#{ key_id }&vCode=#{ v_code }"
      end
    end
  end
end
