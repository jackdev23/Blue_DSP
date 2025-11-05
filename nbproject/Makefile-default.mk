#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=${DISTDIR}/MC_804_BLUE.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=${DISTDIR}/MC_804_BLUE.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=h/timers.c src/adcdacDrv.c src/f300_2400.s src/f300_2700.s src/f550_850cw.s src/FIR_Filter.s src/firlms2.s src/main.c src/OneButton.c src/oled.c src/twiddleFactors.c src/fft.c src/highpass.s src/configuration_bits.c src/clrClkFail.s src/traps.c src/f300_1800.s "src/DEE Emulation 16-bit.c" "src/Flash Operations.s" src/funcSelector.c src/f300_2100.s

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/h/timers.o ${OBJECTDIR}/src/adcdacDrv.o ${OBJECTDIR}/src/f300_2400.o ${OBJECTDIR}/src/f300_2700.o ${OBJECTDIR}/src/f550_850cw.o ${OBJECTDIR}/src/FIR_Filter.o ${OBJECTDIR}/src/firlms2.o ${OBJECTDIR}/src/main.o ${OBJECTDIR}/src/OneButton.o ${OBJECTDIR}/src/oled.o ${OBJECTDIR}/src/twiddleFactors.o ${OBJECTDIR}/src/fft.o ${OBJECTDIR}/src/highpass.o ${OBJECTDIR}/src/configuration_bits.o ${OBJECTDIR}/src/clrClkFail.o ${OBJECTDIR}/src/traps.o ${OBJECTDIR}/src/f300_1800.o "${OBJECTDIR}/src/DEE Emulation 16-bit.o" "${OBJECTDIR}/src/Flash Operations.o" ${OBJECTDIR}/src/funcSelector.o ${OBJECTDIR}/src/f300_2100.o
POSSIBLE_DEPFILES=${OBJECTDIR}/h/timers.o.d ${OBJECTDIR}/src/adcdacDrv.o.d ${OBJECTDIR}/src/f300_2400.o.d ${OBJECTDIR}/src/f300_2700.o.d ${OBJECTDIR}/src/f550_850cw.o.d ${OBJECTDIR}/src/FIR_Filter.o.d ${OBJECTDIR}/src/firlms2.o.d ${OBJECTDIR}/src/main.o.d ${OBJECTDIR}/src/OneButton.o.d ${OBJECTDIR}/src/oled.o.d ${OBJECTDIR}/src/twiddleFactors.o.d ${OBJECTDIR}/src/fft.o.d ${OBJECTDIR}/src/highpass.o.d ${OBJECTDIR}/src/configuration_bits.o.d ${OBJECTDIR}/src/clrClkFail.o.d ${OBJECTDIR}/src/traps.o.d ${OBJECTDIR}/src/f300_1800.o.d "${OBJECTDIR}/src/DEE Emulation 16-bit.o.d" "${OBJECTDIR}/src/Flash Operations.o.d" ${OBJECTDIR}/src/funcSelector.o.d ${OBJECTDIR}/src/f300_2100.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/h/timers.o ${OBJECTDIR}/src/adcdacDrv.o ${OBJECTDIR}/src/f300_2400.o ${OBJECTDIR}/src/f300_2700.o ${OBJECTDIR}/src/f550_850cw.o ${OBJECTDIR}/src/FIR_Filter.o ${OBJECTDIR}/src/firlms2.o ${OBJECTDIR}/src/main.o ${OBJECTDIR}/src/OneButton.o ${OBJECTDIR}/src/oled.o ${OBJECTDIR}/src/twiddleFactors.o ${OBJECTDIR}/src/fft.o ${OBJECTDIR}/src/highpass.o ${OBJECTDIR}/src/configuration_bits.o ${OBJECTDIR}/src/clrClkFail.o ${OBJECTDIR}/src/traps.o ${OBJECTDIR}/src/f300_1800.o ${OBJECTDIR}/src/DEE\ Emulation\ 16-bit.o ${OBJECTDIR}/src/Flash\ Operations.o ${OBJECTDIR}/src/funcSelector.o ${OBJECTDIR}/src/f300_2100.o

# Source Files
SOURCEFILES=h/timers.c src/adcdacDrv.c src/f300_2400.s src/f300_2700.s src/f550_850cw.s src/FIR_Filter.s src/firlms2.s src/main.c src/OneButton.c src/oled.c src/twiddleFactors.c src/fft.c src/highpass.s src/configuration_bits.c src/clrClkFail.s src/traps.c src/f300_1800.s src/DEE Emulation 16-bit.c src/Flash Operations.s src/funcSelector.c src/f300_2100.s



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/MC_804_BLUE.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33FJ128MC804
MP_LINKER_FILE_OPTION=,--script=p33FJ128MC804.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/h/timers.o: h/timers.c  .generated_files/flags/default/cf00c5025d6a7e616c52bffcf1d3667741315689 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/h" 
	@${RM} ${OBJECTDIR}/h/timers.o.d 
	@${RM} ${OBJECTDIR}/h/timers.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  h/timers.c  -o ${OBJECTDIR}/h/timers.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/h/timers.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/adcdacDrv.o: src/adcdacDrv.c  .generated_files/flags/default/253d1e2e14e35e722c13fbbec5a9cfd1fa455a6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/adcdacDrv.o.d 
	@${RM} ${OBJECTDIR}/src/adcdacDrv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/adcdacDrv.c  -o ${OBJECTDIR}/src/adcdacDrv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/adcdacDrv.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/main.o: src/main.c  .generated_files/flags/default/b6a8d8779e8dbf134ac0ed476d101836a9d5f85c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.o.d 
	@${RM} ${OBJECTDIR}/src/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/main.c  -o ${OBJECTDIR}/src/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/main.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/OneButton.o: src/OneButton.c  .generated_files/flags/default/9ff7f3d39a8877734c586c59e2be02bc076db62a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/OneButton.o.d 
	@${RM} ${OBJECTDIR}/src/OneButton.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/OneButton.c  -o ${OBJECTDIR}/src/OneButton.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/OneButton.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/oled.o: src/oled.c  .generated_files/flags/default/83b35b97ffa652cdd9123c782e0131c75b90c3fc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/oled.o.d 
	@${RM} ${OBJECTDIR}/src/oled.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/oled.c  -o ${OBJECTDIR}/src/oled.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/oled.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/twiddleFactors.o: src/twiddleFactors.c  .generated_files/flags/default/fad752b2c29d996de1cfb75dd005dde3cccb3dfd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/twiddleFactors.o.d 
	@${RM} ${OBJECTDIR}/src/twiddleFactors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/twiddleFactors.c  -o ${OBJECTDIR}/src/twiddleFactors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/twiddleFactors.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/fft.o: src/fft.c  .generated_files/flags/default/629237dac0d934d634bba64c4a33968e58f12e8b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/fft.o.d 
	@${RM} ${OBJECTDIR}/src/fft.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/fft.c  -o ${OBJECTDIR}/src/fft.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/fft.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/configuration_bits.o: src/configuration_bits.c  .generated_files/flags/default/d38337781c1c2c75c2ca4935fd4c3873e70d6ef5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/configuration_bits.o.d 
	@${RM} ${OBJECTDIR}/src/configuration_bits.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/configuration_bits.c  -o ${OBJECTDIR}/src/configuration_bits.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/configuration_bits.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/traps.o: src/traps.c  .generated_files/flags/default/f181e3b61e0f9c166f708b1a6e846fdf2dc822d5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/traps.o.d 
	@${RM} ${OBJECTDIR}/src/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/traps.c  -o ${OBJECTDIR}/src/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/traps.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/DEE Emulation 16-bit.o: src/DEE\ Emulation\ 16-bit.c  .generated_files/flags/default/eb16bde01cb6ad78e455dc2a73778b89446d4377 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} "${OBJECTDIR}/src/DEE Emulation 16-bit.o".d 
	@${RM} "${OBJECTDIR}/src/DEE Emulation 16-bit.o" 
	${MP_CC} $(MP_EXTRA_CC_PRE)  "src/DEE Emulation 16-bit.c"  -o "${OBJECTDIR}/src/DEE Emulation 16-bit.o"  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/DEE Emulation 16-bit.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/funcSelector.o: src/funcSelector.c  .generated_files/flags/default/125e2ef020c7641cd5fc9f76d3968c6408de307e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/funcSelector.o.d 
	@${RM} ${OBJECTDIR}/src/funcSelector.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/funcSelector.c  -o ${OBJECTDIR}/src/funcSelector.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/funcSelector.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
else
${OBJECTDIR}/h/timers.o: h/timers.c  .generated_files/flags/default/e69ebe90ac64135a2973c646f0973805a35a1557 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/h" 
	@${RM} ${OBJECTDIR}/h/timers.o.d 
	@${RM} ${OBJECTDIR}/h/timers.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  h/timers.c  -o ${OBJECTDIR}/h/timers.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/h/timers.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/adcdacDrv.o: src/adcdacDrv.c  .generated_files/flags/default/cfdb297a374c717b76c9041d6da4c6561a2e2b5d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/adcdacDrv.o.d 
	@${RM} ${OBJECTDIR}/src/adcdacDrv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/adcdacDrv.c  -o ${OBJECTDIR}/src/adcdacDrv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/adcdacDrv.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/main.o: src/main.c  .generated_files/flags/default/6323e0805a929e5c12ca7c6a3ccc323736509d78 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.o.d 
	@${RM} ${OBJECTDIR}/src/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/main.c  -o ${OBJECTDIR}/src/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/main.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/OneButton.o: src/OneButton.c  .generated_files/flags/default/17000a312c27acd0acc25067c5ff90a86859674e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/OneButton.o.d 
	@${RM} ${OBJECTDIR}/src/OneButton.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/OneButton.c  -o ${OBJECTDIR}/src/OneButton.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/OneButton.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/oled.o: src/oled.c  .generated_files/flags/default/1c3e1d4dc374e4219199df81772f9f48f73c5155 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/oled.o.d 
	@${RM} ${OBJECTDIR}/src/oled.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/oled.c  -o ${OBJECTDIR}/src/oled.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/oled.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/twiddleFactors.o: src/twiddleFactors.c  .generated_files/flags/default/ff14b22eb7e7c2949694249e6d49488ebb2da1af .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/twiddleFactors.o.d 
	@${RM} ${OBJECTDIR}/src/twiddleFactors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/twiddleFactors.c  -o ${OBJECTDIR}/src/twiddleFactors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/twiddleFactors.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/fft.o: src/fft.c  .generated_files/flags/default/28b46273913de47e10c6b1b2da75727c01a94d28 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/fft.o.d 
	@${RM} ${OBJECTDIR}/src/fft.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/fft.c  -o ${OBJECTDIR}/src/fft.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/fft.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/configuration_bits.o: src/configuration_bits.c  .generated_files/flags/default/1ae9458af6b71cd44041be9559394c052b795842 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/configuration_bits.o.d 
	@${RM} ${OBJECTDIR}/src/configuration_bits.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/configuration_bits.c  -o ${OBJECTDIR}/src/configuration_bits.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/configuration_bits.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/traps.o: src/traps.c  .generated_files/flags/default/25e1b1c7dd1c8a4e62a0593a731a12fd66ff4ab3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/traps.o.d 
	@${RM} ${OBJECTDIR}/src/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/traps.c  -o ${OBJECTDIR}/src/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/traps.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/DEE Emulation 16-bit.o: src/DEE\ Emulation\ 16-bit.c  .generated_files/flags/default/5d353d0156d19837a001a4dc5b772ff1b6e5a575 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} "${OBJECTDIR}/src/DEE Emulation 16-bit.o".d 
	@${RM} "${OBJECTDIR}/src/DEE Emulation 16-bit.o" 
	${MP_CC} $(MP_EXTRA_CC_PRE)  "src/DEE Emulation 16-bit.c"  -o "${OBJECTDIR}/src/DEE Emulation 16-bit.o"  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/DEE Emulation 16-bit.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/src/funcSelector.o: src/funcSelector.c  .generated_files/flags/default/84d2f87d222f6cd2dafc391be3a773b95a7f1683 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/funcSelector.o.d 
	@${RM} ${OBJECTDIR}/src/funcSelector.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/funcSelector.c  -o ${OBJECTDIR}/src/funcSelector.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/funcSelector.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off   
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/f300_2400.o: src/f300_2400.s  .generated_files/flags/default/1187c319df6701a0dc810639262fe292d26a7d0e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2400.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2400.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2400.s  -o ${OBJECTDIR}/src/f300_2400.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2400.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/f300_2700.o: src/f300_2700.s  .generated_files/flags/default/26e09b48423d9e280da7ff65d94040ee91c1c8d2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2700.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2700.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2700.s  -o ${OBJECTDIR}/src/f300_2700.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2700.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/f550_850cw.o: src/f550_850cw.s  .generated_files/flags/default/d075abe8062797619fbcbf066e142437a28a8c31 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f550_850cw.o.d 
	@${RM} ${OBJECTDIR}/src/f550_850cw.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f550_850cw.s  -o ${OBJECTDIR}/src/f550_850cw.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f550_850cw.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/FIR_Filter.o: src/FIR_Filter.s  .generated_files/flags/default/f12564c27073156b55cded0f05bfa79a33b0a4eb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/FIR_Filter.o.d 
	@${RM} ${OBJECTDIR}/src/FIR_Filter.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/FIR_Filter.s  -o ${OBJECTDIR}/src/FIR_Filter.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/FIR_Filter.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/firlms2.o: src/firlms2.s  .generated_files/flags/default/6f59c89ffeff927291e73f5438c7252c508c84be .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/firlms2.o.d 
	@${RM} ${OBJECTDIR}/src/firlms2.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/firlms2.s  -o ${OBJECTDIR}/src/firlms2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/firlms2.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/highpass.o: src/highpass.s  .generated_files/flags/default/196b827bb15a7f4626db90e5c225b436b082b63b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/highpass.o.d 
	@${RM} ${OBJECTDIR}/src/highpass.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/highpass.s  -o ${OBJECTDIR}/src/highpass.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/highpass.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/clrClkFail.o: src/clrClkFail.s  .generated_files/flags/default/fd3febda2e7c7208018806a3aaa06cb5b95e042f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/clrClkFail.o.d 
	@${RM} ${OBJECTDIR}/src/clrClkFail.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/clrClkFail.s  -o ${OBJECTDIR}/src/clrClkFail.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/clrClkFail.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/f300_1800.o: src/f300_1800.s  .generated_files/flags/default/ad0adc20e8ef1bc709531b2123741d3d0efade87 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_1800.o.d 
	@${RM} ${OBJECTDIR}/src/f300_1800.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_1800.s  -o ${OBJECTDIR}/src/f300_1800.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_1800.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/Flash Operations.o: src/Flash\ Operations.s  .generated_files/flags/default/cd5894b296bc8ce4676c702e16b59bcf5393eac .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} "${OBJECTDIR}/src/Flash Operations.o".d 
	@${RM} "${OBJECTDIR}/src/Flash Operations.o" 
	${MP_CC} $(MP_EXTRA_AS_PRE)  "src/Flash Operations.s"  -o "${OBJECTDIR}/src/Flash Operations.o"  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/Flash Operations.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/f300_2100.o: src/f300_2100.s  .generated_files/flags/default/46764ef620596d159149bf4f3e81adf70423e922 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2100.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2100.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2100.s  -o ${OBJECTDIR}/src/f300_2100.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2100.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
else
${OBJECTDIR}/src/f300_2400.o: src/f300_2400.s  .generated_files/flags/default/44e7c24b8ae76aca9b916dd62bf83858c75d3340 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2400.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2400.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2400.s  -o ${OBJECTDIR}/src/f300_2400.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2400.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/f300_2700.o: src/f300_2700.s  .generated_files/flags/default/ec84947d1a3f9c3c54249c62e717ef6165b506f9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2700.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2700.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2700.s  -o ${OBJECTDIR}/src/f300_2700.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2700.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/f550_850cw.o: src/f550_850cw.s  .generated_files/flags/default/a77557ec0625a8ca632b56f7f4896868fa496070 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f550_850cw.o.d 
	@${RM} ${OBJECTDIR}/src/f550_850cw.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f550_850cw.s  -o ${OBJECTDIR}/src/f550_850cw.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f550_850cw.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/FIR_Filter.o: src/FIR_Filter.s  .generated_files/flags/default/aa960c89df921b9805c6db52c2e84031b1ff0db2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/FIR_Filter.o.d 
	@${RM} ${OBJECTDIR}/src/FIR_Filter.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/FIR_Filter.s  -o ${OBJECTDIR}/src/FIR_Filter.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/FIR_Filter.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/firlms2.o: src/firlms2.s  .generated_files/flags/default/fb247a574dce0ede44fa78828b8ba814fd96f13a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/firlms2.o.d 
	@${RM} ${OBJECTDIR}/src/firlms2.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/firlms2.s  -o ${OBJECTDIR}/src/firlms2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/firlms2.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/highpass.o: src/highpass.s  .generated_files/flags/default/2d07b1780276dde8850000cdcd5724c93c045147 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/highpass.o.d 
	@${RM} ${OBJECTDIR}/src/highpass.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/highpass.s  -o ${OBJECTDIR}/src/highpass.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/highpass.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/clrClkFail.o: src/clrClkFail.s  .generated_files/flags/default/44043aee7f7ce93e454e8d4babe1d5be19a229bb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/clrClkFail.o.d 
	@${RM} ${OBJECTDIR}/src/clrClkFail.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/clrClkFail.s  -o ${OBJECTDIR}/src/clrClkFail.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/clrClkFail.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/f300_1800.o: src/f300_1800.s  .generated_files/flags/default/c584e8329c87a75c20327abca626b01627025115 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_1800.o.d 
	@${RM} ${OBJECTDIR}/src/f300_1800.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_1800.s  -o ${OBJECTDIR}/src/f300_1800.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_1800.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/Flash Operations.o: src/Flash\ Operations.s  .generated_files/flags/default/bafaba181200d4fa901dc8e4e1553d7998db5b3e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} "${OBJECTDIR}/src/Flash Operations.o".d 
	@${RM} "${OBJECTDIR}/src/Flash Operations.o" 
	${MP_CC} $(MP_EXTRA_AS_PRE)  "src/Flash Operations.s"  -o "${OBJECTDIR}/src/Flash Operations.o"  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/Flash Operations.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/src/f300_2100.o: src/f300_2100.s  .generated_files/flags/default/1a08ff42a2031a096a788222a70f10c7689ca9b3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2100.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2100.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2100.s  -o ${OBJECTDIR}/src/f300_2100.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2100.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/MC_804_BLUE.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  libdsp-coff.a lib/nslibv6_33F.a  
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/MC_804_BLUE.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}    libdsp-coff.a lib\nslibv6_33F.a  -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG   -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)      -Wl,,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  
	
else
${DISTDIR}/MC_804_BLUE.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  libdsp-coff.a lib/nslibv6_33F.a 
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/MC_804_BLUE.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}    libdsp-coff.a lib\nslibv6_33F.a  -mcpu=$(MP_PROCESSOR_OPTION)        -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  
	${MP_CC_DIR}\\xc16-bin2hex ${DISTDIR}/MC_804_BLUE.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a    
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(wildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
