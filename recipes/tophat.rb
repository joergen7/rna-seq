#
# Cookbook:: rna-seq
# Recipe:: tophat
#
# Copyright:: 2015-2019 Jörgen Brandt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

tophat_tar = "#{node["dir"]["archive"]}/tophat-2.1.1.tar.gz" 
tophat_dir = "#{node["dir"]["software"]}/tophat-2.1.1"

directory node["dir"]["archive"]
directory node["dir"]["software"]

package "gcc"
package "g++-5"
package "libboost-thread-dev"

remote_file tophat_tar do
  action :create_if_missing
  source "https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.tar.gz"
  retries 1
end

bash 'extract_tophat' do
  code <<-SCRIPT
tar xf #{tophat_tar} -C #{node["dir"]["software"]}
rm #{tophat_tar}
  SCRIPT
  creates tophat_dir
end

bash 'configure_tophat' do
  code "./configure CC=gcc-5 CXX=g++-5"
  cwd tophat_dir
  creates "#{tophat_dir}/Makefile"
end

bash 'compile_tophat' do
  code "make"
  cwd tophat_dir
  creates "#{tophat_dir}/src/tophat"
end

link "#{node["dir"]["bin"]}/tophat" do
  to "#{tophat_dir}/src/tophat"
end