# coding: utf-8
#
# Cookbook Name:: rna-seq
# Recipe:: data
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

fq_link = "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE32nnn/GSE32038/suppl/GSE32038_simulated_fastq_files.tar.gz"
fq_dir  = "#{node["dir"]["data"]}/fastq"
fq_tar  = "#{fq_dir}/#{File.basename( fq_link )}"

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

# download BDGP6 reference genome
remote_file bdgp6_tar do
  action :create_if_missing
  source bdgp6_link
  retries 1
end

bash "extract_bdgp6" do
  code <<-SCRIPT
tar xf #{bdgp6_tar} -C #{node["dir"]["data"]} Drosophila_melanogaster/Ensembl/BDGP6
mv #{node["dir"]["data"]}/Drosophila_melanogaster/Ensembl/BDGP6 #{node["dir"]["data"]}/BDGP6
rm -rf #{node["dir"]["data"]}/Drosophila_melanogaster
  SCRIPT
  not_if "#{Dir.exists?( bdgp6_dir )}"
end
