[ "libjpeg-dev",
  "zlib1g-dev",
  "libfreetype6-dev",
  "python-psycopg2",
  "libmysqlclient-dev",
  "python-dev", 
  "git" ].each do |pkg|
  package pkg do
    action :install
  end
end
