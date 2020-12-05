################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../sine.c 

CMD_SRCS += \
../lnkx.cmd 

OBJS += \
./sine.obj 

C_DEPS += \
./sine.pp 

OBJS__QTD += \
".\sine.obj" 

C_DEPS__QTD += \
".\sine.pp" 

C_SRCS_QUOTED += \
"../sine.c" 


# Each subdirectory must supply rules for building sources it contributes
sine.obj: ../sine.c $(GEN_OPTS)
	@echo 'Building file: $<'
	@echo 'Invoking: Compiler'
	"C:/Program Files (x86)/Texas Instruments/ccsv4/tools/compiler/c5500/bin/cl55" -g --include_path="C:/Program Files (x86)/Texas Instruments/ccsv4/tools/compiler/c5500/include" --diag_warning=225 --ptrdiff_size=16 --no_mac_expand --memory_model=large --preproc_with_compile --preproc_dependency="sine.pp" $(GEN_OPTS_QUOTED) $(subst #,$(wildcard $(subst $(SPACE),\$(SPACE),$<)),"#")
	@echo 'Finished building: $<'
	@echo ' '


