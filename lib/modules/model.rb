module ManyToManyCountCache

  def self.counter_cache(models = [])
    models.each do |m|
      define_method "#{m}=" do |items|
        @update_count_cache_items = {} if @update_count_cache_items.nil?
        @update_count_cache_items[m] = self[m] || self.method(m).call || []
        self[m] = items
        binding.pry
      end
    end
  end


  def self.update_counters(counter_items)
    binding.pry
    counter_items.each do |k,v|
      if v != self[k]

        decrement_arr = v - self[k]
        increment_arr = self[k] - v

        counter_name = "#{self.class.table_name}_count".to_sym
        model = k.to_s.singularize.camelize.constantize
        
        decrement_arr.each do |c|
          model.decrement_counter(counter_name, c.id)
        end

        increment_arr.each do |c|
          model.increment_counter(counter_name, c.id)
        end
      end
    end
  end

end