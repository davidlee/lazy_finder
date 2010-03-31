require File.join(File.dirname(__FILE__),'lib/lazy_finder')
ActiveRecord::Base.extend LazyFinder::ActiveRecordClassMethods
