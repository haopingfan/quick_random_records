require 'quick_random_records/version'
require 'active_record'

class ActiveRecord::Base
  def self.random_query(quantity)
    model_range = 1..self.last.id
    sample_ids = [*model_range].sample(quantity)
    samples = self.where(id: sample_ids)

    while samples.size < quantity
      complement = nil
      while complement.nil?
        complement_id = rand(model_range)
        next if sample_ids.include?(complement_id)

        sample_ids << complement_id
        complement = self.find_by(id: complement_id)
      end

      samples << complement
    end

    samples
  end
end
