#
# Cookbook:: rna-seq
# Recipe:: data
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

fq_link = "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE32nnn/GSE32038/suppl/GSE32038_simulated_fastq_files.tar.gz"
fq_dir  = "#{node["dir"]["data"]}/GSE32038"
fq_tar  = "#{node["dir"]["archive"]}/#{File.basename( fq_link )}"

bdgp6_link = "ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Drosophila_melanogaster/Ensembl/BDGP6/Drosophila_melanogaster_Ensembl_BDGP6.tar.gz"
bdgp6_tar = "#{node["dir"]["archive"]}/#{File.basename( bdgp6_link )}"
bdgp6_dir = "#{node["dir"]["data"]}/BDGP6"

directory node["dir"]["data"]
directory node["dir"]["archive"]
directory fq_dir

# download FastQ data
remote_file fq_tar do
  action :create_if_missing
  source fq_link
  retries 1
end

bash "extract_reads" do
  code <<-SCRIPT
tar xf #{fq_tar} -C #{fq_dir}
rm #{fq_tar}
gunzip *
chmod a+rw *
  SCRIPT
  cwd fq_dir
  creates "#{fq_dir}/GSM794483_C1_R1_1.fq"
end

# download BDGP6 reference genome
remote_file bdgp6_tar do
  action :create_if_missing
  source bdgp6_link
  retries 1
end

bash "extract_bdgp6" do
  code <<-SCRIPT
tar xf #{bdgp6_tar} -C #{node["dir"]["data"]} Drosophila_melanogaster/Ensembl/BDGP6
rm #{bdgp6_tar}
mv #{node["dir"]["data"]}/Drosophila_melanogaster/Ensembl/BDGP6 #{node["dir"]["data"]}/BDGP6
rm -rf #{node["dir"]["data"]}/Drosophila_melanogaster
  SCRIPT
  not_if "#{Dir.exists?( bdgp6_dir )}"
end
