class PaginatedRequest
  include Enumerable

  attr_reader :page, :uri

  class UnsuccessfulRequest < RuntimeError; end

  def initialize(uri)
    @uri = uri
    @page = 0
  end

  def each
    while more_data?
      do_request
      yield json["results"]
      @page += 1
    end
  end

  private
    attr_accessor :json

    def do_request
      response = Faraday.get(uri, {page: page})
      if response.status != 200
        msg = "CollegeScorecard API returned status #{response.status} for #{uri}"
        raise UnsuccessfulRequest, msg
      end

      self.json = JSON.parse(response.body)
    end

    def more_data?
      !json || page * per_page < total
    end

    def per_page
      json["metadata"]["per_page"]
    end

    def total
      json["metadata"]["total"]
    end
end
