class Feed
  class Activity < Hashie::Mash
    attr_reader :feed

    def initialize(feed, data = {})
      @feed = feed
      super(data)
    end

    def as_json(options = {})
      json = to_h.transform_values { |val| get_stream_id(val) }.symbolize_keys
      json[:time] = json[:time]&.iso8601
      json[:to] = json[:to]&.compact&.map { |val| get_stream_id(val) }
      json.compact
    end

    def create
      feed.activities.add(self)
    end

    def update
      feed.activities.update(self)
    end

    def destroy
      feed.activities.destroy(self)
    end

    private

    def get_stream_id(obj)
      obj.respond_to?(:stream_id) ? obj.stream_id : obj
    end
  end
end
