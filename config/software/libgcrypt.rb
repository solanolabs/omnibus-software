#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


name "libgcrypt"
default_version "1.6.1"

dependency "libgpg-error"
dependency "zlib"

version "1.6.1" do
  source :md5 => "a5a5060dc2f80bcac700ab0236ea47dc"
end

source :url => "ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
relative_path "libgcrypt-#{version}"

configure_env = {
  "LDFLAGS"     => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS"      => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "PATH"        => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-libgpg-error-prefix=#{install_dir}/embedded"].join(" "), :env => configure_env
   command "make -j #{max_build_jobs}", :env=>configure_env
   command "make -j #{max_build_jobs} install"
end
