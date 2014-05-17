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

name "mysqlclient"
default_version "6.1.3"

dependency "gettext"


source :url => "http://dev.mysql.com/get/Downloads/Connector-C/mysql-connector-c-#{version}-src.tar.gz",
       :md5 => '490e2dd5d4f86a20a07ba048d49f36b2'

relative_path "mysql-connector-c-#{version}-src"
configure_env =     {
      "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib",
      "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include"
    }

build do
  command "cmake -G \"Unix Makefiles\" -DCMAKE_INSTALL_PREFIX=#{install_dir}/embedded"
  command "make -j #{max_build_jobs}", :env => configure_env
  command "make -j #{max_build_jobs} install"

end
