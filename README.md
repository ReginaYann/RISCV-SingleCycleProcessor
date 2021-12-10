## README

#### 思路

*增加andi、ori、bne：（✔）
    看singleriscv.v中的maindec module：
	andi和ori在I-type中。需要在alu中增加and/or？
	needless：bne在BEQ中
    andi和ori不用改别的东西吧？
    bne要在singleriscv.v的datapath这个模块里的next PC logic中，修改一下pcsrc的赋值，剩下的应该也不用改？？

*编写一个alupart的模块（✔）

*要改一改singleriscv_fpga.v模块？把display_7seg和BCD2bin、bin2BCD加进去。应该只用改那三个注释对应的句子吧（✔）

 太坑了！还要把seg和an的定义改一改，不然显示出来全是反的

*需要写汇编文件，似乎是要用这个汇编文件取代之前的riscvtest.asm，形成新的dat和coe文件（汇编！好难debug！） （✔）

#### 文件夹中的文件

（按照名称排序）

| 文件名             | 文件简介                                                     |
| ------------------ | ------------------------------------------------------------ |
| alupart.v          | 实现module alu32                                             |
| bcd2bin.v          | 实现BCD码向二进制的转换，与lab2的略有不同，将输出的二进制改为了16位 |
| bin2bcd.v          | 实现二进制向BCD码的转换，与lab2中相同                        |
| display_7seg.v     | 数码管显示，与lab4中一样                                     |
| dmem_io.v          | 原始文件自带，未作更改                                       |
| imem.v             | 原始文件自带，未做更改                                       |
| ori_riscvtest.asm  | 原始文件自带，仅更改文件名（之后会自己编写一个新的riscvtest.asm） |
| ori_riscvtest.dat  | 原始文件自带，仅更改文件名（之后会生成一个新的riscvtest.dat） |
| ori_riscvtest.coe  | 原始文件自带，仅更改文件名（之后会生成一个新的riscvtest.coe） |
| riscvparts.v       | 原始文件自带，未做更改                                       |
| riscvtest.asm      | 自己重新编写的汇编文件（根据说明书的要求写的）               |
| riscvtest.dat      | 根据riscvtest.asm生成的dat文件                               |
| riscvtest.coe      | 由新的dat文件手动改写成的coe文件                             |
| singleriscv.v      | 原始文件自带，在加入指令bne时修改了next PC logic             |
| singleriscv.vpp    | iverilog -o                                                  |
| singleriscv.xdc    | 原始文件自带，未做更改                                       |
| singleriscv_fpga.v | 原始文件自带，按照注释的提示把display_7seg和BCD2bin、bin2BCD加进去。修改output类型的定义:[6:0]->[0:6] |
| singleriscv_tb.v   | 原始文件自带，未做更改                                       |

