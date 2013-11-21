default[:zerovm][:sources] = {
  "zerovm" => "https://github.com/zerovm/zerovm.git",
  "zrt" => "https://github.com/zerovm/zrt.git",
  "validator" => "https://github.com/zerovm/validator.git",
  "toolchain" => "https://github.com/zerovm/toolchain.git",
  "linux-headers-for-nacl" => "https://github.com/zerovm/linux-headers-for-nacl.git",
  "gcc" => "https://github.com/zerovm/gcc.git",
  "glibc" => "https://github.com/zerovm/glibc.git",
  "newlib" => "https://github.com/zerovm/newlib.git",
  "binutils" => "https://github.com/zerovm/binutils.git",
  "gdb" => "https://github.com/zerovm/gdb.git"
}

default[:zerovm][:prefix] = "/opt"
default[:zerovm][:root] = "#{default[:zerovm][:prefix]}/zerovm"
default[:zerovm][:zrt_root] = "#{default[:zerovm][:prefix]}/zrt"
default[:zerovm][:home] = "#{default[:zerovm][:prefix]}/zvm-root"
default[:zerovm][:toolchain] = "#{default[:zerovm][:prefix]}/zvm-toolchain"

default[:zerovm][:debugger] = false
