# coding: utf-8
#
# Cookbook Name:: rna-seq
# Recipe:: data
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

fq_link = "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE32nnn/GSE32038/suppl/GSE32038_simulated_fastq_files.tar.gz"
fq_dir  = "#{node.dir.data}/fastq"
fq_tar  = "#{fq_dir}/#{File.basename( fq_link )}"
  
directory node.dir.data
directory fq_dir

# download input data
remote_file fq_tar do
  action :create_if_missing
  source fq_link
  retries 1
  not_if "#{File.exists?( "#{fq_dir}/GSM794483_C1_R1_1.fq" )}"
end

bash "extract_reads" do
  code <<-SCRIPT
tar xf #{fq_tar}
rm #{fq_tar}
gunzip *.gz
  SCRIPT
  cwd fq_dir
  not_if "#{File.exists?( "#{fq_dir}/GSM794483_C1_R1_1.fq" )}"
end
