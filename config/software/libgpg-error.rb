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


name "libgpg-error"
default_version "1.9"


version "1.9" do
  source :md5 => "6dde8fd075aef8eaf8d3ae414447bb35"
end

source :url => "ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-#{version}.tar.gz"
relative_path "libgpg-error-#{version}"

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-libraries=#{install_dir}/embedded/lib"].join(" "), :env => configure_env
   command "make -j #{max_build_jobs}", :env=>configure_env
   command "make -j #{max_build_jobs} install"
end
