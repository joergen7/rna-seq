# coding: utf-8
#
# Cookbook Name:: rna-seq
# Recipe:: tools
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::tophat"
include_recipe "chef-bioinf-worker::cufflinks"
include_recipe "chef-bioinf-worker::cummerbund"
