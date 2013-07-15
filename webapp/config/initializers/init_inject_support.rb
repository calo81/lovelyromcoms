require_relative "object_container"
module Inject
  def method_missing(meth, *args)
    return super unless meth == :inject
    args.each do |to_inject|
       self.class_eval do
         define_method(to_inject) do
            ObjectContainer.get(to_inject.to_sym)
         end
       end
    end
  end
end

class Object
  extend Inject
end

