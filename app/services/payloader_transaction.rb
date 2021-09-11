require 'dry/monads/result'
require 'dry/monads/do'
require 'dry/matcher'
require 'dry/matcher/result_matcher'

module PayloaderTransaction
  def self.included(base)
    base.include(Dry::Monads::Result::Mixin)
    base.include(Dry::Monads::Do.for(:call))
    base.include(Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher))
  end
end
