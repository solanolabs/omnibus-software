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
#

name "nginx-passenger"
default_version "1.4.5"

dependency "pcre"
dependency "openssl"
dependency "libffi"
dependency "libsqlite3"

source :url => "http://nginx.org/download/nginx-#{version}.tar.gz",
       :md5 => "1a635e9543570f0c881b8ec9db0c6898"

relative_path "nginx-#{version}"

build do
   gem ["install passenger",
       "-v 4.0.37",
       "-n #{install_dir}/bin",
       "--no-rdoc --no-ri"].join(" ")
 
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-http_ssl_module",
           "--with-http_stub_status_module",
           "--with-debug",
           "--add-module=#{install_dir}/embedded/lib/ruby/gems/1.9.1/gems/passenger-4.0.37/ext/nginx",
           "--with-ld-opt=-L#{install_dir}/embedded/lib",
           "--with-cc-opt=\"-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include\""].join(" ")
  command "make -j #{max_build_jobs}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "make install"
end
