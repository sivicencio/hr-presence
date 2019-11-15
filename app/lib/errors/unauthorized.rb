# Source code taken from https://driggl.com/blog/a/handling-exceptions-in-rails-applications
# Thanks to them for providing this solution

module Errors
  class Unauthorized < Errors::StandardError
    def initialize
      super(
        title: "Unauthorized",
        status: 401,
        detail: message || "You need to sign in before continuing.",
      )
    end
  end
end