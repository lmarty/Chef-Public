module SortableHash
  def sorted_hash(hash=nil)
    hash ||= self
    hash = hash.to_hash if hash.respond_to?(:to_hash)
    if(hash.is_a?(Hash))
      new_hash = defined?(OrderedHash) ? OrderedHash.new : Hash.new
      hash.keys.sort.each do |key|
        new_hash[key] = case hash[key]
        when Mash
          sort_hash(hash[key].to_hash)
        when Hash
          sort_hash(hash[key])
        else
          hash[key]
        end
      end
      new_hash
    else
      hash
    end
  end
end

Chef::Mash.send(:include, SortableHash)
Chef::Node::Attribute.send(:include, SortableHash)
unless(Hash.instance_methods.map(&:to_sym).include?(:sorted_hash))
  Hash.send(:include, SortableHash)
end
