import os
from setuptools import setup

# Utility function to read the README file.
# Used for the long_description.  It's nice, because now 1) we have a top level
# README file and 2) it's easier to type in the README file than to put a raw
# string in below ...
def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(
    name = "LLVM_Datalog",
    version = "0.0.1",
    author = "George Balatsouras",
    author_email = "gbalats@gmail.com",
    description = ("A static analysis framework that uses the LogicBlox "
                   "Datalog engine for analyzing LLVM bitcode."),
    license = "MIT",
    keywords = "LLVM datalog static analysis",
    url = "https://github.com/plast-lab/llvm-datalog",
    py_modules = ['__main__'],
    packages = ['cli', 'resources', 'tests', 'utils'],
    package_data = { 'resources' :  ['inFrance.txt'] },
    # long_description = read('README.txt'),
    classifiers=[
        "Development Status :: 3 - Alpha",
        "License :: OSI Approved :: MIT License",
        "Operating System :: POSIX :: Linux",
        "Topic :: Utilities",
    ],)
