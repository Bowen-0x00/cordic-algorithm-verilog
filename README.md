# cordic-algorithm-verilog

使用Cordic算法函数运算，在资源受限的设备上运行（如资源较少的FPGA、嵌入式MCU），避免了浮点运算、乘法、除法，只用移位和加法函数的计算。


## atan2

经过权衡，目前atan的误差 < 0.006°

代码使用Verilog编写，查表数据使用python脚本生成。

使用简单的SystemVerilog进行了[0, 360°]测试。


### 原理

![](images/Cordic.excalidraw.png)