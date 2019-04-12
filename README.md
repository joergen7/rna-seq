# RNA-seq

This workflow exemplifies the comparison of DNA expression levels in two experimental conditions from RNA-Seq data. It reimplements a study by [Trapnell et al. 2012](http://www.nature.com/nprot/journal/v7/n3/full/nprot.2012.016.html).

A detailed description can be found on the [Cuneiform website](http://cuneiform-lang.org/examples/2016/02/26/rna-seq/). This cookbook installs all necessary tools, downloads all necessary data, sets up Cuneiform, and places the [workflow](https://github.com/joergen7/rna-seq/blob/master/templates/default/rna-seq.cf.erb) in a predetermined location. The cookbook can be run on any system in a virtual machine. For running the cookbook natively, an Ubuntu 16.04 or higher is required.

Below you find installation instructions for, both, the native and the virtual machine setup.


## Requirements

### Platforms

- Ubuntu 18.04

### Cookbooks

- chef-cuneiform
  - chef-rebar3
    -erlang
      - build-essential
      - mingw
      - seven_zip
      - windows
      - yum-epel
      - yum-erlang_solutions

### Recipes

- `rna-seq::bowtie` installs Bowtie 1.1.2 which is a Bowtie release old enough to be compatible with TopHat
- `rna-seq::data` downloads the *Drosophila melanogaster* reference genome from iGenomes and the simulated transcripome samples for two conditions from NCBI
- `rna-seq::tools` installs SAMtools, Cufflinks, R, CummeRbund, and triggers the recipes for Bowtie and TopHat
- `rna-seq::tophat` installs TopHat 2.1.1 which is the last TopHat release published before the tool was discontinued in 2016
- `rna-seq::workflow` installs the RNA-seq Cuneiform workflow under `/opt/wf`

## Running the Workflow

If you set up the workflow via `kitchen converge`, log into the machine by typing

    kitchen login
    
Execute the workflow script by entering

    cuneiform -d /opt/data /opt/wf/rna-seq.cfl
    
## Authors

- Jörgen Brandt ([@joergen7](https://github.com/joergen7/)) [joergen@cuneiform-lang.org](mailto:joergen@cuneiform-lang.org)

## License

[Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)