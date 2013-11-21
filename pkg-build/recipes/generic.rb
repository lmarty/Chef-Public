=begin
builder => type -> git
           commands and junk

node[:pkg_build][:customs].each do |artifact|

  name = artifact[:
    self.send("builder_#{artifact[:builder][:type]}", artifact[:name]) do
      artifact[:builder].each_pair do |k,v|
        next if k == 'type'
        self.send(k, v)
      end
    end
  end
  
end
=end
