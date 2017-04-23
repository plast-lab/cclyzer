[![License MIT][badge-license]](LICENSE.txt)

![CCLYZER](/cclyzer-logo.png)
=============================

A tool for analyzing LLVM bitcode (generated either by C or C++) using
Datalog.

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

The LogicBlox engine needs to be installed. We recommend the 
[PA-Datalog](http://snf-705535.vm.okeanos.grnet.gr/agreement.html) engine, 
which is a modified LogicBlox v3 engine, intended for use in program analysis projects. 

(Alternatively, you can download a full-fledged LogicBlox engine (version 3.*) 
from the [LogicBlox Download Page](https://download.logicblox.com/). 
You will need to [request an academic license]
(http://www.logicblox.com/learn/academic-license-request-form/).)

You must also set the environment variable `$LOGICBLOX_HOME` and
augment your `$PATH` accordingly. The following additions to either
your `.bashrc` or `.bash_profile` should suffice, assuming that you
have extracted the engine to `/opt/lb/`. If not, adjust the following
lines appropriately:

    export LOGICBLOX_HOME=/opt/lb/logicblox-3.10.14/logicblox
    export PATH=$LOGICBLOX_HOME/bin:$PATH


### Install LLVM

This step is not needed for newer Linux distributions, where you can
install LLVM version 3.7 (or later) from the system's package manager.

* Download LLVM 3.7.0 pre-built binary from the
  [LLVM Download Page](http://www.llvm.org/releases/download.html#3.7.0).
* Untar the downloaded file to a destination path of your choice
  (e.g., `/opt/llvm/`) and modify permissions accordingly. 
* Add the `/path/to/llvm-3.7.0/bin` to your `$PATH` (by modifying your
  `.bashrc` or `.bash_profile`). 

### Additional Libraries

You will also have to install the following packages:

#### Fedora 20, 21, 22

    # yum install boost-devel boost-python protobuf-devel python-pip python-devel

#### Fedora 24

    # dnf install boost-devel boost-python protobuf-devel python-pip python-devel
    # dnf install llvm-devel clang-devel

#### Ubuntu

    # apt-get install build-essential libboost-dev libboost-filesystem-dev libboost-program-options-dev libboost-python-dev libprotobuf-dev libprotoc-dev protobuf-compiler python-pip python-dev

#### Ubuntu 15.10

In latest distro versions, that have switched to gcc 5, the binary
compatibility between clang and gcc is broken (see
[bug 23529](https://llvm.org/bugs/show_bug.cgi?id=23529)). So, the
pre-built LLVM binaries will not work there.

Instead, for Ubuntu 15.10, you can:

1. Skip the pre-built binary download step entirely, but otherwise
   follow the (Ubuntu) instructions

2. Additionally install LLVM 3.7 and libedit from the system's package manager by
   running:

        # apt-get install llvm-3.7 libedit-dev

3. When compiling the project, run `make` as follows:

        (venv)$ LLVM_CONFIG=llvm-config-3.7 make
        (venv)$ make install


#### YAML Configuration

To be able to easily customize your analysis via a configuration file,
you will also need to install the `python-yaml` package.

The default user configuration will be automagically installed at
`~/.config/cclyzer/config.yaml` the first time you run the tool. Then,
you can tweak this config file, e.g., to change the printed statistics
and the loaded logic modules.


Installation
------------

We recommend first to create a
[virtual environment](http://docs.python-guide.org/en/latest/dev/virtualenvs/)
by running:

    $ pip install virtualenv  # if not already installed
    $ cd /path/to/cclyzer/
    $ virtualenv venv


To activate the virtual environment, run:

    $ . venv/bin/activate
    (venv)$    # <--- your prompt should change to something like this


Now, while inside the virtualenv, build `cclyzer` as follows:

    (venv)$ make
    (venv)$ make install


Then, you should be able to run the main `cclyzer` script that analyzes
LLVM Bitcode. Try:

    (venv)$ cclyzer -h
    (venv)$ cclyzer analyze -h


Testing
-------

The basic test suite comprises the [GNU Core Utilities](https://www.gnu.org/software/coreutils/).

You may run all the tests with:

    $ make tests.run

or a particular test, e.g., `stty`, with:

    $ make test-stty

It is also possible to invoke a python interpreter for a more
interactive experience:

    $ python
    >>> from cclyzer import *
    >>> config = AnalysisConfig('./tests/coreutils-8.24/sort.bc', output_dir='./build/tests/sort')
    >>> analysis = Analysis(config)
    >>> analysis.run()
    ...
    >>> print analysis.stats
    # instructions        : 25417
    # functions           :   438
    # app functions       :   317
    ...
    >>>


Troubleshooting
---------------

The warnings and errors that may come up during execution are not very
informative. Instead, the log file located at
`$XDG_CACHE_HOME/cclyzer/cclyzer.log` (which at most systems defaults to
`~/.cache/cclyzer/cclyzer.log`), or the *system log*, can be much more
helpful.


[badge-license]: https://img.shields.io/badge/license-MIT-green.svg
