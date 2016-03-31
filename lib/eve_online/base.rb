require 'open-uri'
require 'nori'
require 'active_support/time'

module EveOnline
  class Base
    attr_reader :parser

    def initialize
      @parser = Nori.new(advanced_typecasting: false)
    end

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
  end
end
