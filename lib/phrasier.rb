Bundler.require
require_all "lib/phrasier"

module Phrasier
  class << self

    def start
      Phrasier.new
    end

  end
end
