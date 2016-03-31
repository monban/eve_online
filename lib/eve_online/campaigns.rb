module EveOnline
  class Campaigns < CrestApi
    API_ENDPOINT = 'https://public-crest.eveonline.com/sovereignty/campaigns/'

    def result
      @result ||= response.fetch('items')
    end
    def url
      API_ENDPOINT
    end
  end
end

