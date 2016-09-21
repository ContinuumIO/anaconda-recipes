Legacy recipes
==============

Historically, the system (started in July of 2012) was only able to
process so-called Anaconda recipes, which we now refer to as "legacy recipes".
In June 2013 `conda-build` was created as an open source project from the existing
Anaconda build system code base, but with slightly different recipes which allows
users to work easily on individual packages, without having to setup up the
Anaconda build system (which wouldn't even be possible as it connects to Continuum
internal servers).  We continued to build packages using legacy recipes,
and conda recipes evolved in the community, along with changes and
new features in `conda-build`.  In August 2015, the ability to call out
to `conda-build`, and thereby understand conda recipes was added to the internal
system.

By now almost all recipes have been converted to conda recipes, but a few remain
in the legacy format, which is almost identical to conda recipes with a few subtle
differences:

  * Legacy recipes list requirements (both run and build-time) only by name,
    although the resulting conda package will specify version requirements
    determined by the system, where as in conda recipes, you specify all
    version requirements explicitly, unless the new `pin_depends` option
    is used, see <a href="https://github.com/conda/conda-build/pull/741">
    PR 741</a>.
  * Also, there are many features in `conda-build`, which the original
    system does not support.
    Most importantly `build/detect_binary_files_with_prefix`.
  * There are slight differences in how environment variables are set during
    the execution of `build.sh` and `bld.bat`.

These legacy recipes (like all conda recipes), are meant to be built using
the `conda-build` command, see: https://github.com/conda/conda-build
However, it might be necessary to make some small changes in order to make the
recipe work, as legacy recipes have not been tested to work with conda-build.
If you have trouble with a legacy recipe, please submit an issue to this repository.
