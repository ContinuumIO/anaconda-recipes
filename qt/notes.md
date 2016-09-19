## Notes concerning Linux

- Lots of patches have been applied for CentOS 5.11 support.
- There are still issues with XRandr on that distro being too old.
  This isn't so bad since the version is dynamically determined,
  but it does mean that HiDPI is tempremental on CentOS 5.11 itself.
- WebEngine isn't possible on CentOS 5.11 due to lack of egl.

## Notes concerning OS X

- To build Qt5 you need XCode in your system, Command Line Tools is not
  accepted. See this [Qt bug](https://bugreports.qt.io/browse/QTBUG-41908)
  for details.
- The minimal XCode version accepted is 6.1
- The minimal OS X version accepted for building is 10.9 (Mavericks)

## Notes concerning Windows:

- WebEngine isn't possible on Windows due to using Visual Studio 2008
  and also (on later Visual Studios) due to bad DirectX support in VMs.
  By that I mean VirtualBox specifically where it takes the entire system
  down.
- Building from source requires preparing the environment outside conda
  (see http://qt-project.org/doc/qt-5/windows-requirements.html):

    * ActivePerl
    * Ruby (currently you need to download this and install to C:\Ruby23)
    * Python (2.7 for QtWebEngine) (handled for you in bld.bat)
    * DirectX SDK
    * Visual C++ 2010:

      1. Install Visual Studio 2010
      2. Install Windows SDK 7.1
      3. Install Visual Studio 2010 SP1
      4. Install Visual C++ 2010 SP1 Compiler Update for the Windows SDK 7.1
      5. Copy glext.h, wglext.h, and glxext.h from
         http://www.opengl.org/registry/ into
         `C:\Program Files\ Microsoft SDKs\Windows\v7.1\Include\gl`

  You may also have to make sure perl and ruby can be found on the `%PATH%`. I
  also installed openssl and grep for windows. OpenSSL was necessary for
  PyQt-5.3.1 (but should not be for PyQt-5.3.2). The instructions at
  http://trac.webkit.org/wiki/BuildingQtOnWindows were especially helpful, and
  include links to build dependencies.

  When I get a chance, I will replace as many of these external dependencies as
  possible with packages from the msys2 channel.

  This recipe assumes the computer on which Qt-5 will be installed has drivers
  supporting opengl. It could be rebuilt removing the `-opengl desktop` config
  parameter to use ANGLE, which ships with the qt5 sources, however tha cannot
  be built for Visual Studio 2008 due to heavy use of C++11 and beyond.

  Qt5, especially QtWebKit, have a few source files with paths that are long
  enough to cause problems for the MSVC compiler, which has a 260 character
  constraint. This caused problems when I installed anaconda in
  `C:\Users\myprofile\anaconda` (particularly when compiling the third-party
  webp graphics plugin for qtwebkit). For this reason the build is performed
  in a directory at the root of the C: drive.
