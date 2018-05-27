require 'quick_random_records/version'
require 'active_record'
require 'rails_or'

class ActiveRecord::Base
  def self.random_records(quantity, mode: 1, multiple: 1.25, loop_limit: 3)
    case mode
    when 1
      self.sample_complement_records(quantity, multiple, loop_limit)
    when 2
      self.order_rand_limit_records(quantity)
    when 3
      self.pluck_sample_records(quantity)
    end
  end

  private

  def self.sample_complement_records(quantity, multiple, loop_limit)
    min_max = self.pluck('MIN(id), MAX(id)').first
    id_range = (min_max[0]..min_max[1])

    samples = [*id_range].sample(quantity * multiple)
    exist_samples = self.where(id: samples).pluck(:id)
    exist_samples_size = exist_samples.size
    deficit = quantity - exist_samples_size
    exist_samples_size = 1 if exist_samples_size.zero?
    deficit_weight = quantity * multiple / exist_samples_size
    n = 1

    while deficit > 0 && n <= loop_limit
      complements = ([*id_range] - samples).sample(deficit * multiple * deficit_weight * n)
      exist_complements = self.where(id: complements).pluck(:id)

      deficit -= exist_complements.size
      samples += complements
      exist_samples += exist_complements
      n += 1
    end

    self.where(id: exist_samples[0...quantity])
  end

  def self.order_rand_limit_records(quantity)
   adapter_type = connection.adapter_name.downcase.to_sym
    case adapter_type
    when :mysql, :mysql2
      self.order("RAND()").limit(quantity)
    when :sqlite, :postgresql
      self.order("RANDOM()").limit(quantity)
    else
      raise NotImplementedError, "Unknown adapter type '#{adapter_type}'"
    end
  end

  def self.pluck_sample_records(quantity)
    ids = self.pluck(:id).sample(quantity)
    self.where(id: ids)
  end
end
