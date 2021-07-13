class CollegeScorecard
  attr_accessor :api_key, :per_page
  attr_reader :uri

  BASE_URI = URI("https://api.data.gov/ed/collegescorecard/v1/")
  DEFAULT_FIELDS = %w[id school.name location]

  class << self
    def schools
        new("schools")
    end
  end

  def initialize(endpoint)
    @api_key = ENV["COLLEGESCORECARD_KEY"]
    @per_page = 50
    @uri = URI.join(BASE_URI, endpoint)
  end

  def all(fields: DEFAULT_FIELDS)
    search({}, fields: fields)
  end

  def search(search_hash, fields: DEFAULT_FIELDS)
    query = search_hash.merge({
        api_key: api_key,
        fields: fields.join(","),
        per_page: per_page,
    })
    uri.query = URI.encode_www_form(query)
    paginator = PaginatedRequest.new(uri)

    if block_given?
      paginator.each { |results| yield results }
    else
      paginator.first
    end
  end
end
