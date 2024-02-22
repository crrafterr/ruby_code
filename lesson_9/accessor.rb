module Accessor
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        attr_reader_with_history(name)
        attr_writer_with_history(name)
      end
    end

    def strong_attr_accessor(name, type)
      define_method(name) { instance_variable_get("@#{name}".to_sym) }
      define_method("#{name}=") do |value|
        raise unless value.instance_of?(type)

        instance_variable_set("@#{name}".to_sym, value)
      end
    end

    private

    def attr_reader_with_history(name)
      define_method(name) { instance_variable_get("@#{name}".to_sym) }
      define_method("#{name}_history".to_sym) { instance_variable_get("@#{name}_history".to_sym) }
    end

    def attr_writer_with_history(name)
      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}".to_sym, value)
        instance_variable_set("@#{name}_history".to_sym, []) if instance_variable_get("@#{name}_history".to_sym).nil?
        instance_variable_get("@#{name}_history".to_sym) << value
      end
    end
  end
end
