#!/usr/bin/env python

import sys, os
import xml.etree.ElementTree as et

PREFIX = "sh"

moduleNameIdentifier = {}
storyboardNameIdentifier = {}
segueIdentifiers = {}
controllerIdentifiers = {}
reuseIdentifiers = {}

def addModuleNameIdentifier(identifier):
    key = os.path.basename(identifier)
    identifier = key[:-11]
    key = identifier + "ModuleName"
    if not key.startswith(PREFIX.upper()):
        key = PREFIX.upper() + key
    
    moduleNameIdentifier[key] = identifier

def addStoryboardNameIdentifier(identifier):
    key = os.path.basename(identifier)
    identifier = key[:-11]
    key = identifier + "StoryboardName"
    if not key.startswith(PREFIX.upper()):
        key = PREFIX.upper() + key
    
    storyboardNameIdentifier[key] = identifier

def addSegueIdentifier(identifier):
	key = identifier[0].upper() + identifier[1:]
	if not key.startswith(PREFIX.upper()):
		key = PREFIX.upper() + key
	
	segueIdentifiers[key] = identifier

def addControllerIdentifier(identifier):
    key = identifier[0].upper() + identifier[1:]
    if not key.startswith(PREFIX.upper()):
        key = PREFIX.upper() + key
    
    controllerIdentifiers[key] = identifier

def addReuseIdentifier(identifier):
  key = identifier[0].upper() + identifier[1:]
  if not key.startswith(PREFIX.upper()):
    key = PREFIX.upper() + key

  reuseIdentifiers[key] = identifier

def process_storyboard(file):
    tree = et.parse(file)
    root = tree.getroot()
    
    addModuleNameIdentifier(file)
    
    addStoryboardNameIdentifier(file)
    
    for segue in root.iter("segue"):
        segueIdentifier = segue.get("identifier")
        if segueIdentifier == None:
            continue
        addSegueIdentifier(segueIdentifier)
    
    for controller in root.findall(".//*[@storyboardIdentifier]"):
        controllerIdentifier = controller.get("storyboardIdentifier")
        if controllerIdentifier == None:
            continue
        addControllerIdentifier(controllerIdentifier)

    for cell in root.findall(".//*[@reuseIdentifier]"):
      reuseIdentifier = cell.get("reuseIdentifier")
      if reuseIdentifier == None:
        continue
      addReuseIdentifier(reuseIdentifier)

def writeHeader(file, identifiers):
    constants = sorted(identifiers.keys())
    
    for constantName in constants:
        file.write("extern NSString * const " + constantName + ";\n")

def writeImplementation(file, identifiers):
    constants = sorted(identifiers.keys())
    
    for constantName in constants:
        file.write("NSString * const " + constantName + " = @\"" + identifiers[constantName] + "\";\n")

count = os.environ["SCRIPT_INPUT_FILE_COUNT"]
for n in range(int(count)):
    process_storyboard(os.environ["SCRIPT_INPUT_FILE_" + str(n)])

with open(sys.argv[1], "w+") as header:
    header.write("/* Generated document. DO NOT CHANGE */\n\n")
    header.write("@class NSString;\n")
    
    header.write("\n")
    header.write("/* Module name constants */\n")
    writeHeader(header, moduleNameIdentifier)
    
    header.write("\n")
    header.write("/* Storyboard name constants */\n")
    writeHeader(header, storyboardNameIdentifier)
    
    header.write("\n")
    header.write("/* Segue identifier constants */\n")
    
    writeHeader(header, segueIdentifiers)
    
    header.write("\n")
    header.write("/* Controller identifier constants */\n")
    
    writeHeader(header, controllerIdentifiers)

    header.write("\n")
    header.write("/* Reuse identifier constants */\n")

    writeHeader(header, reuseIdentifiers)

    header.close()

with open(sys.argv[2], "w+") as implementation:
    implementation.write("/* Generated document. DO NOT CHANGE */\n\n")
    
    writeImplementation(implementation, moduleNameIdentifier)
    implementation.write("\n")
    
    writeImplementation(implementation, storyboardNameIdentifier)
    implementation.write("\n")
    
    writeImplementation(implementation, segueIdentifiers)
    implementation.write("\n")
    
    writeImplementation(implementation, controllerIdentifiers)
    implementation.write("\n")

    writeImplementation(implementation, reuseIdentifiers)
    implementation.write("\n")

    implementation.close()

