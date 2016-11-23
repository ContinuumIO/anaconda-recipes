Although it is possible to build the Qt user interface on all systems, we do not
want to pull Qt's dependencies into the build environment for fear that they get
linked into what we build.  Also, building the Qt UI means that a Mac App Bundle
gets built (and all executables placed in it).
