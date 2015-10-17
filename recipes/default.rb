#
# Cookbook Name:: rna-seq
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


fq_link = "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE32nnn/GSE32038/suppl/GSE32038_simulated_fastq_files.tar.gz"



include_recipe "chef-bioinf-worker::tophat"
include_recipe "chef-bioinf-worker::cufflinks"
include_recipe "chef-bioinf-worker::cummerbund"
include_recipe "chef-cuneiform::default"

directory node.dir.wf
directory node.dir.data

# place workflow
template "#{node.dir.wf}/rna-seq.cf" do
  source "rna-seq.cf.erb"
end

# download input data
remote_file "#{node.dir.data}/#{File.basename( fq_link )}" do
  action :create_if_missing
  source fq_link
  retries 1
end

