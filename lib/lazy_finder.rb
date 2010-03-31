module LazyFinder
  ActiveRecord::Base.class_inheritable_accessor :lazy_finder_fields

  def self.included(model)
    # a few sensible defaults
    model.lazy_finder :name, :username, :login, :title, :email, :identifier
  end

  module ClassMethods
    def [](x)
      lazy_finder_fields.map {|f| "find_by_#{f.to_s}" }.each do |f|
        record = self.send(f, x) rescue nil
        return record unless record.nil?
      end
      nil
    end
  end

  module ActiveRecordClassMethods
    def lazy_finder *fields
      options = fields.extract_options!.symbolize_keys
      self.lazy_finder_fields = fields
      extend ClassMethods
    end
  end
end
