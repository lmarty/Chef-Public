node.cpan_plus.deps.each do |m|
    execute "cpan #{m}"
end
