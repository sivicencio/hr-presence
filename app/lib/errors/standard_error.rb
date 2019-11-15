# Source code taken from https://driggl.com/blog/a/handling-exceptions-in-rails-applications
# Thanks to them for providing this solution

module Errors
  class StandardError < ::StandardError
    def initialize(title: nil, detail: nil, status: nil, source: {})
      @title = title || "Something went wrong"
      @detail = detail || "We encountered unexpected error"
      @status = status || 500
    end

    def to_h
      {
        status: status,
        title: title,
        message: detail,
      }
    end

    def serializable_hash
      to_h
    end

    def to_s
      to_h.to_s
    end

    attr_reader :title, :detail, :status, :source
  end
end
