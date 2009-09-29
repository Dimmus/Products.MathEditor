"""
Initialization and package-wide constants.

Author: Philip Schatz (phil@cnx.org)
Copyright (C) 2009 Rice University. All rights reserved.

This software is subject to the provisions of the GNU Lesser General
Public License Version 2.1 (LGPL).  See LICENSE.txt for details.
"""
from Products.CMFCore.DirectoryView import registerDirectory
from Globals import package_home

from config import GLOBALS, PROJECTNAME

registerDirectory(config.SKINS_DIR, config.GLOBALS)

def initialize(context):
    pass

