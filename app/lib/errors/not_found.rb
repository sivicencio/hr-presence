# Source code taken from https://driggl.com/blog/a/handling-exceptions-in-rails-applications
# Thanks to them for providing this solution

module Errors
  class NotFound < Errors::StandardError
    def initialize
      super(
        title: "Record not Found",
        status: 404,
        detail: "We could not find the object you were looking for.",
      )
    end
  end
end
