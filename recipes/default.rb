#
# Cookbook Name:: rna-seq
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


fq_link = "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE32nnn/GSE32038/suppl/GSE32038_simulated_fastq_files.tar.gz"
fq_tar = "#{node.dir.archive}/#{File.basename( fq_link )}"

include_recipe "chef-bioinf-worker::bdgp6"
include_recipe "chef-bioinf-worker::tophat"
include_recipe "chef-bioinf-worker::cufflinks"
include_recipe "chef-bioinf-worker::cummerbund"
include_recipe "chef-cuneiform::default"

directory node.dir.wf
directory node.dir.data
directory "#{node.dir.data}/read"

# place workflow
template "#{node.dir.wf}/rna-seq.cf" do
  source "rna-seq.cf.erb"
end

# download input data
remote_file fq_tar do
  action :create_if_missing
  source fq_link
  retries 1
end

bash "extract_reads" do
  code <<-SCRIPT
tar xf #{fq_tar}
gunzip *.gz
  SCRIPT
  cwd "#{node.dir.data}/read"
  not_if "#{File.exists?( "#{node.dir.data}/read/GSM794483_C1_R1_1.fq" )}"
end
