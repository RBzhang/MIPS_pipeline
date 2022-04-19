# MIPS五段流水线设计

## 文件介绍
define.sv: 宏定义  
pc_new.sv：时钟更新模块  
IF_ID.sv: 取指-译码流水切割段  
ID_EX.sv: 译码-执行流水切割  
EX_MEM.sv: 执行-访存流水切割  
MEM_WB.sv: 访存-写回流水切割  
memory_read.sv : 代码文件  
control.sv: 控制信号生成  
ALUcon.sv : 生成ALU控制信号  
alu.sv : ALU运算  
register_file.sv : 寄存器文件  
select_signal : 旁路控制单元，解决数据冒险  
memory_data.sv : 存储器  
top.sv : 顶层模块  
TestBench.sv : 测试  
SimSrcGen.sv : 测试时钟、复位信号生成  

## 支持指令

### R型：
SLL
SRA
SRL
ADD
ADDU
SUB
AND
OR
SLT
SLTU
JR

### 分支跳转指令：

J
BNE
BEQ
JAL

### I型指令：

ADDI
ANDI
ADDIU
ALTI
ORI
LW
SW

## 初步测试

用下面代码进行测试

ADDI    $18, $0, #8   

ADDI    $16, $0, #1  

Label:  

ADD     $20, $16,$0  

JAL     f  

BNE     $18, $16,Label  

J       exit  

f:  

SW      $16, 4($0)  

LW      $17, 4($0)  

ADD     $17,$17,$17  

ADD     $16,$17, $0  

JR      $ra  

exit:  

ADD     $21, $20, $0  



最终结果应该是

$16:    0X00000008
$17:    0X00000008
$18:    0X00000008
$20:    0X00000004
$21:    0X00000004
