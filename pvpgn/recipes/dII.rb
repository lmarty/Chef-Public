service "d2cs" do
  supports :enable => true, :start => true
  action [ :enable, :start ]      
end

service "d2dbs" do
  supports :enable => true, :start => true
  action [ :enable, :start ]      
end
