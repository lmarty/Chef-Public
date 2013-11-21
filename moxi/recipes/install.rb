case node.platform_family
when "rhel","fedora"
  include_recipe "moxi::rpm"
else
  raise "Unsupported"
end
