module EveOnline
  class XmlApi < Base
    def cached_until
      @cached_until ||= ActiveSupport::TimeZone['UTC'].parse(eveapi.fetch('cachedUntil'))
    end

    def current_time
      @current_time ||= ActiveSupport::TimeZone['UTC'].parse(eveapi.fetch('currentTime'))
    end

    def version
      eveapi.fetch('@version').to_i
    end

    def eveapi
      @eveapi ||= response.fetch('eveapi')
    end
  end
end
