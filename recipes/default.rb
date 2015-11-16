# coding: utf-8
#
# Cookbook Name:: rna-seq
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


include_recipe "chef-cuneiform::default"
include_recipe "rna-seq::tools"
include_recipe "rna-seq::data"
include_recipe "rna-seq::workflow"






