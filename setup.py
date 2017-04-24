#!/usr/bin/env python

import os
from distutils import sysconfig
from distutils.core import setup
from glob import glob
from os import path

# Get python site-packages directory. This will be correctly resolved
# even in the case we're inside a virtual environment
site_packages_path = sysconfig.get_python_lib()


setup(
    # Application
    name='cclyzer',
    version='1.0',
    description=(
        "A static analysis framework that uses the LogicBlox "
        "Datalog engine for analyzing LLVM bitcode."
    ),

    # Author details
    author='George Balatsouras',
    author_email='gbalats@gmail.com',

    # Application details
    keywords="LLVM datalog static analysis",
    license="MIT",
    url='https://github.com/plast-lab/llvm-datalog',
    classifiers = [
        "Development Status :: 3 - Alpha",
        "License :: OSI Approved :: MIT License",
        "Operating System :: POSIX :: Linux",
        "Topic :: Utilities",
    ],

    # Packages to be included
    packages = [
        'blox', 'cclyzer', 'cclyzer.cli', 'cclyzer.config',
        'cclyzer.runtime', 'cclyzer.collect', 'resources', 'resources.logic',
        'utils'
    ],

    # Additional package data
    package_data = {
        'resources.logic' : [
            '*/*.lbb',
            '*/*/*.lbb',
            '*/*.lbp',
            '*/*.project',
            '*/checksum',
        ],
        'resources' : [
            '*.yaml',
        ],
    },

    # Additional data outside any python packages
    data_files = [
        # Add dynamic libraries
        (site_packages_path, glob(path.join('lib', '*.so'))),
    ],

    # Source code directory
    package_dir = {
        '': 'src/main',
        'resources.logic': 'build/logic',
    },

    # Python scripts
    scripts = [
        'scripts/cclyzer',
        'scripts/gen-protobuf-message',
        'scripts/project-dependencies',
        'scripts/pack-facts.py',
    ],
)
