# Microcode Processor

A VHDL implementation of a microcode processor complete with microcoded control unit, datapath, and memory.

This project was created with the aid of [Xilinx ISE Design Suite 14.7](http://www.xilinx.com/products/design-tools/ise-design-suite.html). To open the project in ISE, open the .xise project file.

The control memory contains the following operations:
```
ADD	-- add register values
ADI	-- add immediate value to register value
INC	-- increment register value
NOT	-- Logical not of register value
LD	-- load from memory into register
SR	-- store to memory from register
CMP	-- compare operands (subtract) and update status flags
JMP	-- unconditional jump
EQ	-- conditional jump, if Z = 1
LDI	-- load immediate value to register
```
