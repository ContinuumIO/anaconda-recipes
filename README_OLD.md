**This repository is deprecated.**

Recipes used in the free 
[Anaconda Python distribution](https://www.continuum.io/downloads) are hosted 
in the Anaconda, Inc managed 
[AnacondaRecipes/aggregate](https://github.com/AnacondaRecipes/aggregate)
repository. This repository holds recipes used in older versions of the distribution.

The following instructions are **outdated** and **unsupported**. 
They are included for historical reference.

Anaconda Recipes
================

This is a Continuum managed repository for recipes used in the
free [Anaconda Python distribution](https://www.continuum.io/downloads).

Building Conda Recipes
================


##### Linux (use separate 32 and 64-bit machines):

Machine and additional software:
 * CentOS release 5.11 
 * gcc 4.4.7 (`yum install gcc44`, link `/usr/bin/gcc` to `gcc44`)
 * GNU Fortran (GCC) 4.4.7

We use a Docker image, “conda_builder_linux”, to build the packages.

Install Docker: 
 
 Linux: 
  * https://docs.docker.com/linux/step_one/ 
  * Start the docker service: sudo service docker start
 
Windows/Mac: 
  * https://www.docker.com/products/docker-toolbox
  * Run Docker Quickstart Terminal

Download the following zip file containing docker: 

 * (64-bit) https://github.com/ContinuumIO/docker-images/blob/master/conda_builder_linux/build64.zip
 * (32-bit) https://github.com/ContinuumIO/docker-images/blob/master/conda_builder_linux/build32.zip

This zip file contains two scripts: docker_wrapper.sh and start_cpp98.sh. Cpp98 indicates that the script sets the default C++ ABI to the older format. This does not preclude compiling C++11 or C++14 code, it only implies the older ABI.

In the Docker Quickstart Terminal, in the directory containing your previously downloaded zip file, run ./start_cpp98.sh (64-bit) or ./start_cpp98_32.sh (32-bit)
You should see the following output: 

    Welcome to the conda-builder image, brought to you by Continuum Analytics.

    Binaries produced with this image should be compatible with any Linux OS
    that is at least CentOS 5 or newer (Glibc lower bound), and anything 
    that uses G++ 5.2 or older (libstdc++ upper bound)

    GCC is: gcc (GCC) 5.2.0
    Default C++ ABI: 4 (C++98)
    GLIBC is: glibc 2.5
    ld/binutils is: GNU ld (GNU Binutils) 2.26.20160125

    Native arch is x86_64.  To build 32-bit code, set the ARCH environment
        variable to 32. (-e "ARCH=32" docker argument)

    The dev user (currently signed in) has passwordless sudo access.
    miniconda (2.7) is installed at /opt/miniconda.
    git is also available.
    Your .gitconfig has been imported.
    Your ssh private key has been imported for passwordless ssh.

    Helpful aliases:
    clone_recipes: clones the conda/conda-recipes repo from Github
    clone_anaconda: clones the continuumIO/anaconda (private) repo from Github
    anaconda_setup: clones anaconda repo and sets up continuum internal build system.

We have successfully loaded the conda-builder image into our Docker container. 

There are two sections to the command line arguments for our start script. 

    ./start_cpp98.sh <arguments fed to docker run> -- <command/arguments to be run in docker container>

The -- is the separator between the two. It is optional; if no command is specified, you are dropped at an interactive bash prompt.

For example, if we want to have our recipes in the container and then be in an interactive bash prompt, we run: 

    ./start_cpp98.sh -v /Users/staged-recipes:/home/dev/code

This loads in our directory “staged-recipes” containing conda recipes into the docker container in /home/dev/code. We can then build our recipes simply by running: conda build <conda package> 

Alternatively, the image can act as a black box. We can add arguements as inputs and recieve outputs.
For example, we can run: 

    ./start_cpp98.sh -v /Users/rjain/cdf/staged-recipes:/home/dev/code -- conda build code/recipes/seaborn

This command goes ahead and builds seaborn without us having to enter the docker container. 

NOTE: In order to build certain conda packages, do the following in the Docker container: 
 * conda install mercurial
 * In addition, in the home directory there should be a .condarc file. If not, create one. The .condarc file should contain: 

    channels:
    - defaults
    
   add_pip_as_python_dependency: False

##### Windows: 

Use a Windows VM with the following specifications: 

  * 64-bit Windows 10
  * VS 2008 (or VC compiler for Python 2.7), 2010 (or Windows 7.1 SDK) , 2015 installed
  * ifort
  NOTE: For VS2008 Pro, you must explicitly enable the 64-bit compiler during setup. During VS 2015 setup, you must explicitly enable native build tools, or else you get no C++ compiler.

Then,
 * Run “conda install mercurial”
 * Modify/create .condarc in the home directory and write: 
 
    channels:
    - defaults
   
   add_pip_as_python_dependency: False

#### OSX:

Use a OSX VM with the following specifications: 
  * Version 10.9.5
  * gcc 4.2.1 (LLVM version 6.0, clang-600.0.57)
  * GNU Fortran (GCC) 4.2.3 (installed via homebrew)

Then, 
 * Run “conda install mercurial”
 * Modify/create .condarc in the home directory and write: 
 
    channels:
    - defaults
    
    add_pip_as_python_dependency: False


Relationship to other recipe repos
==================================

These recipes are mirrors of the recipes maintained internally by ContinuumIO.  Community users are welcome to submit PRs here, and we will incorporate mutually agreed upon changes as time allows.

<a href="https://github.com/conda/conda-recipes">Conda-recipes</a> is somewhat deprecated at this point.  Feel free to continue using it, but you should prefer <a href="https://github.com/conda-forge">conda-forge</a> as a community-driven recipe repo, as well as supporting packages outside of the set supported by defaults.  Conda-forge is used as a reference for updating and fixing recipes in defaults - so submit changes there first, and then submit a PR to anaconda-recipes, showing that your changes work.
