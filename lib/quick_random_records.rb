require 'quick_random_records/version'
require 'active_record'

class << ActiveRecord::Base
  def random_records(quantity, strategy: 1, multiply: 1.05, loop_limit: 3)
    case strategy
    when 1
      sample_complement_records(quantity, multiply, loop_limit)
    when 2
      order_rand_limit_records(quantity)
    when 3
      pluck_sample_records(quantity)
    else
      "this gem doesn't support strategy other than 1, 2, 3"
    end
  end

  private

  def sample_complement_records(quantity, multiply, loop_limit)
    min_max = self.pluck(Arel.sql("MIN(#{self.table_name}.id), MAX(#{self.table_name}.id)")).first
    id_range = (min_max[0]..min_max[1])

    samples = [*id_range].sample(quantity * multiply)
    exist_samples = self.where(id: samples).pluck(:id)
    exist_samples_size = exist_samples.size
    deficit = quantity - exist_samples_size
    exist_samples_size = 1 if exist_samples_size.zero?
    deficit_weight = quantity * multiply / exist_samples_size
    n = 1

    while deficit > 0 && n <= loop_limit
      complements = ([*id_range] - samples).sample(deficit * multiply * deficit_weight * n)
      exist_complements = self.where(id: complements).pluck(:id)

      deficit -= exist_complements.size
      samples += complements
      exist_samples += exist_complements
      n += 1
    end

    self.where(id: exist_samples[0...quantity])
  end

  def order_rand_limit_records(quantity)
   adapter_type = connection.adapter_name.downcase.to_sym
    case adapter_type
    when :mysql, :mysql2
      self.order(Arel.sql("RAND()")).limit(quantity)
    when :sqlite, :postgresql
      self.order(Arel.sql("RANDOM()")).limit(quantity)
    else
      raise NotImplementedError, "Unknown adapter type '#{adapter_type}'"
    end
  end

  def pluck_sample_records(quantity)
    ids = self.pluck(:id).sample(quantity)
    self.where(id: ids)
  end
end
