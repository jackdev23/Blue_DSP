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
FINAL_IMAGE=${DISTDIR}/Blue_DSP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=${DISTDIR}/Blue_DSP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/Blue_DSP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33FJ128MC804
MP_LINKER_FILE_OPTION=,--script=p33FJ128MC804.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/h/timers.o: h/timers.c  .generated_files/flags/default/b0421429ae1c0aff8fa215b4b609aff50cce2c52 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/h" 
	@${RM} ${OBJECTDIR}/h/timers.o.d 
	@${RM} ${OBJECTDIR}/h/timers.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  h/timers.c  -o ${OBJECTDIR}/h/timers.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/h/timers.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/adcdacDrv.o: src/adcdacDrv.c  .generated_files/flags/default/da8acb15933525b01f25c9947039353f1bd942a6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/adcdacDrv.o.d 
	@${RM} ${OBJECTDIR}/src/adcdacDrv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/adcdacDrv.c  -o ${OBJECTDIR}/src/adcdacDrv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/adcdacDrv.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/main.o: src/main.c  .generated_files/flags/default/b9e25a968fe7a3ed07326952db50f0393b408f5b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.o.d 
	@${RM} ${OBJECTDIR}/src/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/main.c  -o ${OBJECTDIR}/src/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/main.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/OneButton.o: src/OneButton.c  .generated_files/flags/default/86b9982a821b523b02b630451f54c427b3cca0d0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/OneButton.o.d 
	@${RM} ${OBJECTDIR}/src/OneButton.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/OneButton.c  -o ${OBJECTDIR}/src/OneButton.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/OneButton.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/oled.o: src/oled.c  .generated_files/flags/default/30752aa940718b5e1d9398e31641b64c1af483d6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/oled.o.d 
	@${RM} ${OBJECTDIR}/src/oled.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/oled.c  -o ${OBJECTDIR}/src/oled.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/oled.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/twiddleFactors.o: src/twiddleFactors.c  .generated_files/flags/default/a20d7f7580ad0680729bf7184cc8b85da587fb06 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/twiddleFactors.o.d 
	@${RM} ${OBJECTDIR}/src/twiddleFactors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/twiddleFactors.c  -o ${OBJECTDIR}/src/twiddleFactors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/twiddleFactors.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/fft.o: src/fft.c  .generated_files/flags/default/921ab4dabc94ce4373e186a57694b1a3ee4ad5bb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/fft.o.d 
	@${RM} ${OBJECTDIR}/src/fft.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/fft.c  -o ${OBJECTDIR}/src/fft.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/fft.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/configuration_bits.o: src/configuration_bits.c  .generated_files/flags/default/550c09b61ea924a46290763089f4264c259d7947 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/configuration_bits.o.d 
	@${RM} ${OBJECTDIR}/src/configuration_bits.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/configuration_bits.c  -o ${OBJECTDIR}/src/configuration_bits.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/configuration_bits.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/traps.o: src/traps.c  .generated_files/flags/default/8c15776ab0e91de0735943ad4d34f1a6e59315ad .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/traps.o.d 
	@${RM} ${OBJECTDIR}/src/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/traps.c  -o ${OBJECTDIR}/src/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/traps.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/DEE Emulation 16-bit.o: src/DEE\ Emulation\ 16-bit.c  .generated_files/flags/default/a1e1a52d8f017c13d0c816685aab3eafd380afad .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} "${OBJECTDIR}/src/DEE Emulation 16-bit.o".d 
	@${RM} "${OBJECTDIR}/src/DEE Emulation 16-bit.o" 
	${MP_CC} $(MP_EXTRA_CC_PRE)  "src/DEE Emulation 16-bit.c"  -o "${OBJECTDIR}/src/DEE Emulation 16-bit.o"  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/DEE Emulation 16-bit.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/funcSelector.o: src/funcSelector.c  .generated_files/flags/default/f8e6a168bc991c58b338368570258ec310772e93 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/funcSelector.o.d 
	@${RM} ${OBJECTDIR}/src/funcSelector.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/funcSelector.c  -o ${OBJECTDIR}/src/funcSelector.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/funcSelector.o.d"      -g -D__DEBUG     -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/h/timers.o: h/timers.c  .generated_files/flags/default/dd9a92c68142752324a251851f4299c55a43273f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/h" 
	@${RM} ${OBJECTDIR}/h/timers.o.d 
	@${RM} ${OBJECTDIR}/h/timers.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  h/timers.c  -o ${OBJECTDIR}/h/timers.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/h/timers.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/adcdacDrv.o: src/adcdacDrv.c  .generated_files/flags/default/bb22f919661c6e1f623a06dec2ebb13afe6a5f02 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/adcdacDrv.o.d 
	@${RM} ${OBJECTDIR}/src/adcdacDrv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/adcdacDrv.c  -o ${OBJECTDIR}/src/adcdacDrv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/adcdacDrv.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/main.o: src/main.c  .generated_files/flags/default/9bba98461a83c6830ff7aaeefd5af068920add1e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.o.d 
	@${RM} ${OBJECTDIR}/src/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/main.c  -o ${OBJECTDIR}/src/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/main.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/OneButton.o: src/OneButton.c  .generated_files/flags/default/9d6e382291ec1315722fb10b0e0c319abca62988 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/OneButton.o.d 
	@${RM} ${OBJECTDIR}/src/OneButton.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/OneButton.c  -o ${OBJECTDIR}/src/OneButton.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/OneButton.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/oled.o: src/oled.c  .generated_files/flags/default/e277b46b8801bcfe5716d0efe69a45c43427def8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/oled.o.d 
	@${RM} ${OBJECTDIR}/src/oled.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/oled.c  -o ${OBJECTDIR}/src/oled.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/oled.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/twiddleFactors.o: src/twiddleFactors.c  .generated_files/flags/default/e3ea9d5733c0e4b90757fd62e8ec471c9d3cdb97 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/twiddleFactors.o.d 
	@${RM} ${OBJECTDIR}/src/twiddleFactors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/twiddleFactors.c  -o ${OBJECTDIR}/src/twiddleFactors.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/twiddleFactors.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/fft.o: src/fft.c  .generated_files/flags/default/7546ebc9a9b8e2a22f9aa1852baf4a1eeef3192b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/fft.o.d 
	@${RM} ${OBJECTDIR}/src/fft.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/fft.c  -o ${OBJECTDIR}/src/fft.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/fft.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/configuration_bits.o: src/configuration_bits.c  .generated_files/flags/default/855390428fed1237ba4b5859f1fb55d1b04ae74d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/configuration_bits.o.d 
	@${RM} ${OBJECTDIR}/src/configuration_bits.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/configuration_bits.c  -o ${OBJECTDIR}/src/configuration_bits.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/configuration_bits.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/traps.o: src/traps.c  .generated_files/flags/default/909b79eef6472c1ae13c9570245ab283169417f3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/traps.o.d 
	@${RM} ${OBJECTDIR}/src/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/traps.c  -o ${OBJECTDIR}/src/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/traps.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/DEE Emulation 16-bit.o: src/DEE\ Emulation\ 16-bit.c  .generated_files/flags/default/3d84722e6b95f20d8bd935c6de17336e695e4cb5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} "${OBJECTDIR}/src/DEE Emulation 16-bit.o".d 
	@${RM} "${OBJECTDIR}/src/DEE Emulation 16-bit.o" 
	${MP_CC} $(MP_EXTRA_CC_PRE)  "src/DEE Emulation 16-bit.c"  -o "${OBJECTDIR}/src/DEE Emulation 16-bit.o"  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/DEE Emulation 16-bit.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/funcSelector.o: src/funcSelector.c  .generated_files/flags/default/55927c15714aa5b3deaedfd4c3ae74a041557803 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/funcSelector.o.d 
	@${RM} ${OBJECTDIR}/src/funcSelector.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  src/funcSelector.c  -o ${OBJECTDIR}/src/funcSelector.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/src/funcSelector.o.d"        -g -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/f300_2400.o: src/f300_2400.s  .generated_files/flags/default/c1bc1969ebbe71eef1a30901f3f453392d0d3e65 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2400.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2400.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2400.s  -o ${OBJECTDIR}/src/f300_2400.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2400.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/f300_2700.o: src/f300_2700.s  .generated_files/flags/default/220b072ef0efdae4d56452e97f614ed39a9c3d0e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2700.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2700.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2700.s  -o ${OBJECTDIR}/src/f300_2700.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2700.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/f550_850cw.o: src/f550_850cw.s  .generated_files/flags/default/807929ba47ce095da8a4195b9e54c614e0fd0ff1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f550_850cw.o.d 
	@${RM} ${OBJECTDIR}/src/f550_850cw.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f550_850cw.s  -o ${OBJECTDIR}/src/f550_850cw.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f550_850cw.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/FIR_Filter.o: src/FIR_Filter.s  .generated_files/flags/default/2d35b97a6ae7c18a47ef54beadbf35c99c6b3563 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/FIR_Filter.o.d 
	@${RM} ${OBJECTDIR}/src/FIR_Filter.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/FIR_Filter.s  -o ${OBJECTDIR}/src/FIR_Filter.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/FIR_Filter.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/firlms2.o: src/firlms2.s  .generated_files/flags/default/29c71a74e4fc2e59b79a9c6eaaac297d90d7a0f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/firlms2.o.d 
	@${RM} ${OBJECTDIR}/src/firlms2.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/firlms2.s  -o ${OBJECTDIR}/src/firlms2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/firlms2.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/highpass.o: src/highpass.s  .generated_files/flags/default/31a3c9cab83b109ed66b1a1695cee3c17c0da8f3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/highpass.o.d 
	@${RM} ${OBJECTDIR}/src/highpass.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/highpass.s  -o ${OBJECTDIR}/src/highpass.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/highpass.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/clrClkFail.o: src/clrClkFail.s  .generated_files/flags/default/582d63e233885545f597b60f71d948b9c9c0139 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/clrClkFail.o.d 
	@${RM} ${OBJECTDIR}/src/clrClkFail.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/clrClkFail.s  -o ${OBJECTDIR}/src/clrClkFail.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/clrClkFail.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/f300_1800.o: src/f300_1800.s  .generated_files/flags/default/7879448f1c7ae73b21ed174574486195476602fa .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_1800.o.d 
	@${RM} ${OBJECTDIR}/src/f300_1800.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_1800.s  -o ${OBJECTDIR}/src/f300_1800.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_1800.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/Flash Operations.o: src/Flash\ Operations.s  .generated_files/flags/default/2c131cd7f283ab69646242f3e17329a4e9e17b4f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} "${OBJECTDIR}/src/Flash Operations.o".d 
	@${RM} "${OBJECTDIR}/src/Flash Operations.o" 
	${MP_CC} $(MP_EXTRA_AS_PRE)  "src/Flash Operations.s"  -o "${OBJECTDIR}/src/Flash Operations.o"  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/Flash Operations.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/f300_2100.o: src/f300_2100.s  .generated_files/flags/default/1f857f69820f6b5492d448698bcb11b44b7a0f8c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2100.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2100.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2100.s  -o ${OBJECTDIR}/src/f300_2100.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2100.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/src/f300_2400.o: src/f300_2400.s  .generated_files/flags/default/28bc9e6cdba90b07fe5fb351d0f985b07a4da0ea .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2400.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2400.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2400.s  -o ${OBJECTDIR}/src/f300_2400.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2400.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/f300_2700.o: src/f300_2700.s  .generated_files/flags/default/71d49d9da1a9235b5e0bc8cb84c0b9ede6e95c9d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2700.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2700.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2700.s  -o ${OBJECTDIR}/src/f300_2700.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2700.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/f550_850cw.o: src/f550_850cw.s  .generated_files/flags/default/c14c2be26c6586cc94bb7b7c6dc3bfb5b851a797 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f550_850cw.o.d 
	@${RM} ${OBJECTDIR}/src/f550_850cw.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f550_850cw.s  -o ${OBJECTDIR}/src/f550_850cw.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f550_850cw.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/FIR_Filter.o: src/FIR_Filter.s  .generated_files/flags/default/3895e5d5bac965ae64c7b97aaa5b12a03da4a728 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/FIR_Filter.o.d 
	@${RM} ${OBJECTDIR}/src/FIR_Filter.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/FIR_Filter.s  -o ${OBJECTDIR}/src/FIR_Filter.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/FIR_Filter.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/firlms2.o: src/firlms2.s  .generated_files/flags/default/ebdad1b85ae6f90c28d9bbe762ec65d29f4f4d91 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/firlms2.o.d 
	@${RM} ${OBJECTDIR}/src/firlms2.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/firlms2.s  -o ${OBJECTDIR}/src/firlms2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/firlms2.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/highpass.o: src/highpass.s  .generated_files/flags/default/a7ce42edfa99a855803a21129d687fdffc732cf3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/highpass.o.d 
	@${RM} ${OBJECTDIR}/src/highpass.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/highpass.s  -o ${OBJECTDIR}/src/highpass.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/highpass.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/clrClkFail.o: src/clrClkFail.s  .generated_files/flags/default/c43c6bcbe0c3ad57fcb5b9768988389d07680120 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/clrClkFail.o.d 
	@${RM} ${OBJECTDIR}/src/clrClkFail.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/clrClkFail.s  -o ${OBJECTDIR}/src/clrClkFail.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/clrClkFail.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/f300_1800.o: src/f300_1800.s  .generated_files/flags/default/546e89b475c21bc282ca330cf500dbe39187d310 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_1800.o.d 
	@${RM} ${OBJECTDIR}/src/f300_1800.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_1800.s  -o ${OBJECTDIR}/src/f300_1800.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_1800.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/Flash Operations.o: src/Flash\ Operations.s  .generated_files/flags/default/b7dee6f7339585ee6818981672d0b0985bfb7ed6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} "${OBJECTDIR}/src/Flash Operations.o".d 
	@${RM} "${OBJECTDIR}/src/Flash Operations.o" 
	${MP_CC} $(MP_EXTRA_AS_PRE)  "src/Flash Operations.s"  -o "${OBJECTDIR}/src/Flash Operations.o"  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/Flash Operations.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/src/f300_2100.o: src/f300_2100.s  .generated_files/flags/default/215a5ac1abe5f5794cca42eb9931acd49cca529e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/f300_2100.o.d 
	@${RM} ${OBJECTDIR}/src/f300_2100.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  src/f300_2100.s  -o ${OBJECTDIR}/src/f300_2100.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/src/f300_2100.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/Blue_DSP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  libdsp-coff.a lib/nslibv6_33F.a  
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/Blue_DSP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}    libdsp-coff.a lib\nslibv6_33F.a  -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG   -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)      -Wl,,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
${DISTDIR}/Blue_DSP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  libdsp-coff.a lib/nslibv6_33F.a 
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/Blue_DSP.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}    libdsp-coff.a lib\nslibv6_33F.a  -mcpu=$(MP_PROCESSOR_OPTION)        -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}\\xc16-bin2hex ${DISTDIR}/Blue_DSP.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a    -mdfp="${DFP_DIR}/xc16" 
	
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
