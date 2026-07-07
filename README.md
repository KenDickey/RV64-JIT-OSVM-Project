# RV64-JIT-OSVM-Project
RV64 Cog/JIT for OpenSmalltalk-VM

Project Status: Early Days -- just started

Game Plan: CogRV64Compiler code for VMMaker

Test Environment is StarFive VisionFive v2 quad-core RV64 SoC

OpenSmalltalk-VM stack interpreter builds fine on VisionFive v2 with current Debian Linux OSOA.
  https://github.com/starfive-tech/VisionFive2

Code backed up here in case I fall over before finishing.

### Background

- Instruction Formats at riscv.org
  https://docs.riscv.org/reference/home/index.html

- Chez Scheme RV64 nativce code back end
  https://github.com/cisco/ChezScheme/blob/main/s/riscv64.ss

- MIT xv6 OS code with thread details and VM pages multi-mapped:
  https://github.com/mit-pdos/xv6-riscv

- Did a simple RV64 assembler for Cuis: 
  https://github.com/KenDickey/BeeYourself/blob/main/RISC5-Instructions.pck.st



