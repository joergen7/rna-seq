# coding: utf-8
#
# Cookbook Name:: rna-seq
# Recipe:: workflow
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

directory node.dir.wf

# place workflow
template "#{node.dir.wf}/rna-seq.cf" do
  source "rna-seq.cf.erb"
end

