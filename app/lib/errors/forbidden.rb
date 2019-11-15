# Source code taken from https://driggl.com/blog/a/handling-exceptions-in-rails-applications
# Thanks to them for providing this solution

module Errors
  class Forbidden < Errors::StandardError
    def initialize
      super(
        title: "Forbidden",
        status: 403,
        detail: "You are not authorized to access this resource.",
      )
    end
  end
end
