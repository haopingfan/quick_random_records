require 'quick_random_records/version'
require 'active_record'
require 'rails_or'

class ActiveRecord::Base
  def self.random_records(quantity)
    id_range = 1..self.last.id
    sample_ids = [*id_range].sample(quantity)
    samples = self.where(id: sample_ids)

    while samples.size < quantity
      complement = []

      while complement.empty?
        complement_id = rand(id_range)
        next if sample_ids.include?(complement_id)

        sample_ids << complement_id
        complement = self.where(id: complement_id)
      end

      samples = samples.or(complement)
    end

    samples
  end
end
