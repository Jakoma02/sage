# -*- coding: utf-8 -*-
"""
Sage Packages
"""

# ****************************************************************************
#       Copyright (C) 2015 Volker Braun <vbraun.name@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#                  https://www.gnu.org/licenses/
# ****************************************************************************

import re
import os
import logging

from sage_bootstrap.env import SAGE_ROOT


log = logging.getLogger()


class Package(object):

    def __init__(self, package_name):
        """
        Sage Package

        A package is defined by a subdirectory of
        ``SAGE_ROOT/build/pkgs/``. The name of the package is the name
        of the subdirectory; The metadata of the package is contained
        in various files in the package directory. This class provides
        an abstraction to the metadata, you should never need to
        access the package directory directly.

        INPUT:

        -- ``package_name`` -- string. Name of the package. The Sage
           convention is that all package names are lower case.
        """
        self.__name = package_name
        self.__tarball = None
        self._init_checksum()
        self._init_version()
        self._init_type()
        self._init_install_requires()
        self._init_dependencies()

    def __repr__(self):
        return 'Package {0}'.format(self.name)

    @property
    def name(self):
        """
        Return the package name

         A package is defined by a subdirectory of
        ``SAGE_ROOT/build/pkgs/``. The name of the package is the name
        of the subdirectory.

        OUTPUT:

        String.
        """
        return self.__name

    @property
    def md5(self):
        """
        Return the MD5 checksum

        Do not use, this is ancient! Use :meth:`sha1` instead.

        OUTPUT:

        String.
        """
        return self.__md5

    @property
    def sha1(self):
        """
        Return the SHA1 checksum

        OUTPUT:

        String.
        """
        return self.__sha1

    @property
    def cksum(self):
        """
        Return the Ck sum checksum

        Do not use, this is ancient! Use :meth:`sha1` instead.

        OUTPUT:

        String.
        """
        return self.__cksum

    @property
    def tarball(self):
        """
        Return the (primary) tarball

        If there are multiple tarballs (currently unsupported), this
        property returns the one that is unpacked automatically.

        OUTPUT:

        Instance of :class:`sage_bootstrap.tarball.Tarball`
        """
        if self.__tarball is None:
            from sage_bootstrap.tarball import Tarball
            self.__tarball = Tarball(self.tarball_filename, package=self)
        return self.__tarball

    def _substitute_variables_once(self, pattern):
        """
        Substitute (at most) one occurrence of variables in ``pattern`` by the values.

        These variables are ``VERSION``, ``VERSION_MAJOR``, ``VERSION_MINOR``,
        ``VERSION_MICRO``, either appearing like this or in the form ``${VERSION_MAJOR}``
        etc.

        Return a tuple:
        - the string with the substitution done or the original string
        - whether a substitution was done
        """
        for var in ('VERSION_MAJOR', 'VERSION_MINOR', 'VERSION_MICRO', 'VERSION'):
            # As VERSION is a substring of the other three, it needs to be tested last.
            dollar_brace_var = '${' + var + '}'
            if dollar_brace_var in pattern:
                value = getattr(self, var.lower())
                return pattern.replace(dollar_brace_var, value, 1), True
            elif var in pattern:
                value = getattr(self, var.lower())
                return pattern.replace(var, value, 1), True
        return pattern, False

    def _substitute_variables(self, pattern):
        """
        Substitute all occurrences of ``VERSION`` in ``pattern`` by the actual version.

        Likewise for ``VERSION_MAJOR``, ``VERSION_MINOR``, ``VERSION_MICRO``,
        either appearing like this or in the form ``${VERSION}``, ``${VERSION_MAJOR}``,
        etc.
        """
        not_done = True
        while not_done:
            pattern, not_done = self._substitute_variables_once(pattern)
        return pattern

    @property
    def tarball_pattern(self):
        """
        Return the (primary) tarball file pattern

        If there are multiple tarballs (currently unsupported), this
        property returns the one that is unpacked automatically.

        OUTPUT:

        String. The full-qualified tarball filename, but with
        ``VERSION`` instead of the actual tarball filename.
        """
        return self.__tarball_pattern

    @property
    def tarball_filename(self):
        """
        Return the (primary) tarball filename

        If there are multiple tarballs (currently unsupported), this
        property returns the one that is unpacked automatically.

        OUTPUT:

        String. The full-qualified tarball filename.
        """
        pattern = self.tarball_pattern
        if pattern:
            return self._substitute_variables(pattern)
        else:
            return None

    @property
    def tarball_upstream_url_pattern(self):
        """
        Return the tarball upstream URL pattern

        OUTPUT:

        String. The tarball upstream URL, but with the placeholder
        ``VERSION``.
        """
        return self.__tarball_upstream_url_pattern

    @property
    def tarball_upstream_url(self):
        """
        Return the tarball upstream URL or ``None`` if none is recorded

        OUTPUT:

        String. The URL.
        """
        pattern = self.tarball_upstream_url_pattern
        if pattern:
            return self._substitute_variables(pattern)
        else:
            return None

    @property
    def tarball_package(self):
        """
        Return the canonical package for the tarball

        This is almost always equal to ``self`` except if the package
        or the ``checksums.ini`` file is a symbolic link. In that case,
        the package of the symbolic link is returned.

        OUTPUT:

        A ``Package`` instance
        """
        n = self.__tarball_package_name
        if n == self.name:
            return self
        else:
            return type(self)(n)

    @property
    def version(self):
        """
        Return the version

        OUTPUT:

        String. The package version. Excludes the Sage-specific
        patchlevel.
        """
        return self.__version

    @property
    def version_major(self):
        """
        Return the major version

        OUTPUT:

        String. The package's major version.
        """
        return self.version.split('.')[0]

    @property
    def version_minor(self):
        """
        Return the minor version

        OUTPUT:

        String. The package's minor version.
        """
        return self.version.split('.')[1]

    @property
    def version_micro(self):
        """
        Return the micro version

        OUTPUT:

        String. The package's micro version.
        """
        return self.version.split('.')[2]

    @property
    def patchlevel(self):
        """
        Return the patchlevel

        OUTPUT:

        Integer. The patchlevel of the package. Excludes the "p"
        prefix.
        """
        return self.__patchlevel

    @property
    def type(self):
        """
        Return the package type
        """
        return self.__type

    @property
    def distribution_name(self):
        """
        Return the Python distribution name or ``None`` for non-Python packages
        """
        if self.__install_requires is None:
            return None
        for line in self.__install_requires.split('\n'):
            line = line.strip()
            if line.startswith('#'):
                continue
            for part in line.split():
                return part
        return None

    @property
    def dependencies(self):
        """
        Return a list of strings, the package names of the (ordinary) dependencies
        """
        # after a '|', we have order-only dependencies
        return self.__dependencies.partition('|')[0].strip().split()

    @property
    def dependencies_order_only(self):
        """
        Return a list of strings, the package names of the order-only dependencies
        """
        return self.__dependencies.partition('|')[2].strip().split() + self.__dependencies_order_only.strip().split()

    @property
    def dependencies_check(self):
        """
        Return a list of strings, the package names of the check dependencies
        """
        return self.__dependencies_order_only.strip().split()

    def __eq__(self, other):
        return self.tarball == other.tarball

    @classmethod
    def all(cls):
        """
        Return all packages
        """
        base = os.path.join(SAGE_ROOT, 'build', 'pkgs')
        for subdir in os.listdir(base):
            path = os.path.join(base, subdir)
            if not os.path.isfile(os.path.join(path, "type")):
                log.debug('%s has no type', subdir)
                continue
            try:
                yield cls(subdir)
            except BaseException:
                log.error('Failed to open %s', subdir)
                raise

    @property
    def path(self):
        """
        Return the package directory
        """
        return os.path.join(SAGE_ROOT, 'build', 'pkgs', self.name)

    def has_file(self, filename):
        """
        Return whether the file exists in the package directory
        """
        return os.path.exists(os.path.join(self.path, filename))

    def _init_checksum(self):
        """
        Load the checksums from the appropriate ``checksums.ini`` file
        """
        checksums_ini = os.path.join(self.path, 'checksums.ini')
        assignment = re.compile('(?P<var>[a-zA-Z0-9_]*)=(?P<value>.*)')
        result = dict()
        try:
            with open(checksums_ini, 'rt') as f:
                for line in f.readlines():
                    match = assignment.match(line)
                    if match is None:
                        continue
                    var, value = match.groups()
                    result[var] = value
        except IOError:
            pass
        self.__md5 = result.get('md5', None)
        self.__sha1 = result.get('sha1', None)
        self.__cksum = result.get('cksum', None)
        self.__tarball_pattern = result.get('tarball', None)
        self.__tarball_upstream_url_pattern = result.get('upstream_url', None)
        # Name of the directory containing the checksums.ini file
        self.__tarball_package_name = os.path.realpath(checksums_ini).split(os.sep)[-2]

    VERSION_PATCHLEVEL = re.compile(r'(?P<version>.*)\.p(?P<patchlevel>[0-9]+)')

    def _init_version(self):
        try:
            with open(os.path.join(self.path, 'package-version.txt')) as f:
                package_version = f.read().strip()
        except IOError:
            self.__version = None
            self.__patchlevel = None
        else:
            match = self.VERSION_PATCHLEVEL.match(package_version)
            if match is None:
                self.__version = package_version
                self.__patchlevel = -1
            else:
                self.__version = match.group('version')
                self.__patchlevel = int(match.group('patchlevel'))

    def _init_type(self):
        with open(os.path.join(self.path, 'type')) as f:
            package_type = f.read().strip()
        assert package_type in [
            'base', 'standard', 'optional', 'experimental'
        ]
        self.__type = package_type

    def _init_install_requires(self):
        try:
            with open(os.path.join(self.path, 'install-requires.txt')) as f:
                self.__install_requires = f.read().strip()
        except IOError:
            self.__install_requires = None

    def _init_dependencies(self):
        try:
            with open(os.path.join(self.path, 'dependencies')) as f:
                self.__dependencies = f.readline().strip()
        except IOError:
            self.__dependencies = ''
        try:
            with open(os.path.join(self.path, 'dependencies_check')) as f:
                self.__dependencies_check = f.readline().strip()
        except IOError:
            self.__dependencies_check = ''
        try:
            with open(os.path.join(self.path, 'dependencies_order_only')) as f:
                self.__dependencies_order_only = f.readline()
        except IOError:
            self.__dependencies_order_only = ''
