module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filter_params)
      results = self.where(nil)
      filter_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end
