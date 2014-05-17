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

name "attr"
default_version "2.4.47"

dependency "gettext"


source :url => "http://download.savannah.gnu.org/releases/attr/attr-#{version}.src.tar.gz",
       :md5 => '84f58dec00b60f2dc8fd1c9709291cc7'

relative_path "attr-#{version}"
configure_env =     {
      "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib",
      "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include"
    }

build do
  command "./configure --enable-shared=no --prefix=#{install_dir}/embedded", :env => configure_env
  command "make -j #{max_build_jobs}"
  command "make -j #{max_build_jobs} install"

end
