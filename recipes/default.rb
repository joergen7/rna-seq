#
# Cookbook Name:: rna-seq
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "tophat"
include_recipe "cufflinks"
include_recipe "cummerbund"
include_recipe "chef-cuneiform::default"
