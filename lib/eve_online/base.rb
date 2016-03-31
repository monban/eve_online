require 'open-uri'
require 'nori'
require 'active_support/time'

module EveOnline
  class Base
    def result
      @result ||= eveapi.fetch('result')
    end

    def url
      raise NotImplementedError
    end

    def user_agent
      @user_agent ||= "EveOnline API (https://github.com/biow0lf/eve_online) v#{ EveOnline::VERSION }"
    end

    def content
      @content ||= open(url, open_timeout: 60, read_timeout: 60,
                             'User-Agent' => user_agent).read
    end

    def response
      @response ||= parser.parse(content)
    end

    def parser
      raise NotImplementedError
    end
  end
end
