# Example of what we want to generate
#11211 = {
# "hashAlgorithm": "CRC",
# "numReplicas": 0,
# "serverList":
#   [
#     "67.214.212.210:11211",
#     "67.214.212.229:11211"
#   ],
# "vBucketMap":
#   [
#     [0],[1]
#   ]
#}

actions :create,  :destroy

attribute :port,           :kind_of => String, :name_attribute => true
attribute :hash_algorithm, :kind_of => String, :default => "CRC"
attribute :num_replicas,   :kind_of => Fixnum, :default => 0
attribute :server_list,    :kind_of => Array,  :required => true
attribute :v_bucket_map,   :kind_of => [Array,String]

def initialize(*args)
    super
    @action = :create
end

