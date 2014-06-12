###############################################################################
################### MOOSE Application Standard Makefile #######################
###############################################################################
#
# Optional Environment variables
# MOOSE_DIR        - Root directory of the MOOSE project 
# HERD_TRUNK_DIR   - Location of the HERD repository
# FRAMEWORK_DIR    - Location of the MOOSE framework
#
###############################################################################
MOOSE_DIR          ?= $(shell dirname `pwd`)/moose
HERD_TRUNK_DIR     ?= $(shell dirname `pwd`)
FRAMEWORK_DIR      ?= $(MOOSE_DIR)/framework
RELAP-7_DIR        ?= $(HERD_TRUNK_DIR)/relap-7
###############################################################################

CURR_DIR    := $(shell pwd)
ROOT_DIR    := $(HERD_TRUNK_DIR)

# framework
include $(FRAMEWORK_DIR)/build.mk
include $(FRAMEWORK_DIR)/moose.mk

################################## MODULES ####################################
HEAT_CONDUCTION   := yes
NAVIER_STOKES     := yes
MISC              := yes
include           $(MOOSE_DIR)/modules/modules.mk
###############################################################################

# dep apps
APPLICATION_DIR    := $(RELAP-7_DIR)
APPLICATION_NAME   := relap-7
DEP_APPS           := $(shell $(FRAMEWORK_DIR)/scripts/find_dep_apps.py $(APPLICATION_NAME))
include            $(FRAMEWORK_DIR)/app.mk
include            $(APPLICATION_DIR)/control_logic.mk

#APPLICATION_DIR    := $(HERD_TRUNK_DIR)/crow
#APPLICATION_NAME   := crow
#DEP_APPS           := $(shell $(FRAMEWORK_DIR)/scripts/find_dep_apps.py $(APPLICATION_NAME))

APPLICATION_DIR    := $(HERD_TRUNK_DIR)/crow
APPLICATION_NAME   := CROW

include 	   $(HERD_TRUNK_DIR)/crow/config.mk
include            $(HERD_TRUNK_DIR)/crow/crow.mk
include            $(HERD_TRUNK_DIR)/crow/crow_python_modules.mk

APPLICATION_DIR    := $(HERD_TRUNK_DIR)/raven
APPLICATION_NAME   := RAVEN

include $(HERD_TRUNK_DIR)/raven/raven.mk

###############################################################################
# Additional special case targets should be added here

