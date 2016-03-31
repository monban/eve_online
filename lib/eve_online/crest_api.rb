require 'json'

module EveOnline
  class CrestApi < Base
    def parser
      return JSON
    end
  end
end
