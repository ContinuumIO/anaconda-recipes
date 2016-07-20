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

We use a Docker image, “conda-builder”, to build the packages.

Install Docker: 
 
 Linux: 
  * https://docs.docker.com/linux/step_one/ 
  * Start the docker service: sudo service docker start
 
Windows/Mac: 
  * https://www.docker.com/products/docker-toolbox
  * Run Docker Quickstart Terminal

Download the following files: 

 * https://github.com/ContinuumIO/docker-images/blob/master/conda_builder_linux/docker_wrapper.sh
 * (64-bit) https://github.com/ContinuumIO/docker-images/blob/master/conda_builder_linux/start_cpp98.sh
 * (32-bit) https://github.com/ContinuumIO/docker-images/blob/master/conda_builder_linux/start_cpp98_32.sh
 * Note: Ensure the files are saved as they are stored in github. For example, if the the docker_wrapper.sh file is downloaded as docker_wrapper.sh.txt, then run: mv docker_wrapper.sh.txt  docker_wrapper.sh

Make each downloaded file executable. Example: chmod +x docker_wrapper.sh

In the Docker Quickstart Terminal, in the directory containing your previously downloaded files, run ./start_cpp98.sh (64-bit) or ./start_cpp98_32.sh (32-bit)
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
We want to have our recipes in the container. An example on how to do so : ./start_cpp98.sh -v /Users/rjain/cdf/staged-recipes:/home/dev/code

This loads in our directory “staged-recipes” containing conda recipes into the docker container in /home/dev/code. We can then build our recipes simply by running: conda build <conda package> in the code directory

Alternatively, the image can act as a black box that we never have to interact with. Instead, we can just use inputs and get outputs. EX: ./start_cpp98.sh -v /Users/rjain/cdf/staged-recipes:/home/dev/code -- conda build code/recipes/seaborn

In order to build certain conda packages, do the following in the Docker container: 
 * conda install mercurial
 * set CIO_TEST=2
 * Ensure conda and conda-build are up to date
 *In addition, in the home directory there should be a .condarc file. If not, create one. The .condarc file should contain: 

    channels:
    - defaults
    - http://bremen/test-pkgs
    
   add_pip_as_python_dependency: False

##### Windows: 

Use a Windows VM with the following specifications: 

  * 64-bit Windows 10
  * VS 2008, 2010, 2015 installed
  * ifort

Then,
 * Run “set CIO_TEST=2”
 * Run “conda install mercurial”
 * Ensure that conda and conda-build are up to date
 * Modify/create .condarc in the home directory and write: 
 
    channels:
    - defaults
    - http://bremen/test-pkgs
   
   add_pip_as_python_dependency: False

#### OSX:

Use a OSX VM with the following specifications: 
  * Version 10.7.5
  * gcc 4.2.1
  * GNU Fortran (GCC) 4.2.3

Then, 
 * Run “set CIO_TEST=2”
 * Run “conda install mercurial”
 * Ensure that conda and conda-build are up to date
 * Modify/create .condarc in the home directory and write: 
 
    channels:
    - defaults
    - http://bremen/test-pkgs
    
    add_pip_as_python_dependency: False


Relationship to other recipe repos
==================================

These recipes are mirrors of the recipes maintained internally by ContinuumIO.  Community users are welcome to submit PRs here, and we will incorporate mutually agreed upon changes as time allows.

Conda-recipes is somewhat deprecated at this point.  Feel free to continue using it, but you should prefer conda-forge as a community-driven recipe repo, as well as supporting packages outside of the set supported by defaults.  Conda-forge is used as a reference for updating and fixing recipes in defaults - so submit changes there first, and then submit a PR to anaconda-recipes, showing that your changes work.
