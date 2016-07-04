Anaconda Recipes
================

This is a Continuum managed repository for recipes used in the
free [Anaconda Python distribution](https://www.continuum.io/downloads).

The machines (and additional software installed) to build these conda
recipes are as follows:

Linux:
  * we use sepatate 32 and 64-bit machines
  * CentOS release 5.11 (Final)
  * gcc 4.4.7 (`yum install gcc44`, link `/usr/bin/gcc` to `gcc44`)
  * GNU Fortran (GCC) 4.4.7

Mac OS X (64-bit):
  * Version 10.7.5
  * gcc 4.2.1
  * GNU Fortran (GCC) 4.2.3

Windows:
  * 64-bit Windows 10
  * VS 2008, 2010, 2015 installed
  * ifort

Relationship to other recipe repos
==================================

These recipes are mirrors of the recipes maintained internally by ContinuumIO.  Community users are welcome to submit PRs here, and we will incorporate mutually agreed upon changes as time allows.

Conda-recipes is somewhat deprecated at this point.  Feel free to continue using it, but you should prefer conda-forge as a community-driven recipe repo, as well as supporting packages outside of the set supported by defaults.  Conda-forge is used as a reference for updating and fixing recipes in defaults - so submit changes there first, and then submit a PR to anaconda-recipes, showing that your changes work.
