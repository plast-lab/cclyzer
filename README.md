LLVM to Datalog
===============

A tool for exporting LLVM bitcode into a Datalog workspace, which can
then be used for static analysis.

This project uses a commercial Datalog engine, developed by
[LogicBlox Inc.](http://www.logicblox.com/).

System requirements
-------------------

* A 64-bit flavor of Linux. Verify that you're running 64-bit Linux by running: `uname -m` which should return x86_64.
* At least 4GB of available memory.
* Python 2.7 or newer (but not Python 3.x). Available from the [Python Website](http://www.python.org/) 
* Java Developer Kit version 6 or newer. Available from [Oracle's Java website](http://www.oracle.com/java)

Pre-installation steps
----------------------

### Install the LogicBlox engine

The LogicBlox engine needs to be installed. Download LogicBlox engine
(version 3.*) from the [LogicBlox Download Page](https://download.logicblox.com/).

To acquire an academic license, fill out
[this form](http://www.logicblox.com/academic-request-form.html).

You must also set the environment variable `$LOGICBLOX_HOME` and
augment your `$PATH` accordingly. The following additions to either
your `.bashrc` or `.bash_profile` should suffice, assuming that you
have extracted the engine to `/opt/lb/`. If not, adjust the following
lines appropriately:

    export LOGICBLOX_HOME=/opt/lb/logicblox-3.10.14/logicblox
    export PATH=$LOGICBLOX_HOME/bin:$PATH


### Install LLVM

* Download LLVM 3.4.1 pre-built binary from the
  [LLVM Download Page](http://www.llvm.org/releases/download.html#3.4.1). 
* Untar the downloaded file to a destination path of your choice
  (e.g., `/opt/llvm/`) and modify permissions accordingly. 
* Add the `/path/to/llvm-3.4.1/bin` to your `$PATH` (by modifying your
  `.bashrc` or `.bash_profile`). 

### Additional Libraries

You will also have to install the following packages:

#### Fedora 20

    # yum install m4 ncurses ncurses-devel boost-devel protobuf-devel

#### Ubuntu

    # apt-get install m4 libncurses5-dev libboost-dev libboost-filesystem-dev libboost-program-options-dev libprotobuf-dev

#### YAML Configuration

To be able to easily customize your analysis via a configuration file,
you will also need to install the `python-yaml` package.

The default user configuration will be automagically installed at
`~/.config/copper/config.yaml` the first time you run the tool. Then,
you can tweak this config file, e.g., to change the printed statistics
and the loaded logic modules.


Installation
------------

Build LLVM-Datalog as follows:

    $ cd /path/to/llvm-datalog/
    $ make
    $ sudo make install
