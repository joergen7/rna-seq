#
# Cookbook:: rna-seq
# Recipe:: samtools
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


samtools_dir = "#{node["dir"]["software"]}/samtools"

directory node["dir"]["software"]

package "gcc"
package "libncurses-dev"

git 'git_clone_samtools' do
  repository "https://github.com/samtools/samtools.git"
  destination samtools_dir
  revision "0.1.18"
end

bash 'compile_samtools' do
  code 'make'
  cwd samtools_dir
  creates "#{samtools_dir}/samtools"
end

link "#{node["dir"]["bin"]}/samtools" do
  to "#{samtools_dir}/samtools"
end