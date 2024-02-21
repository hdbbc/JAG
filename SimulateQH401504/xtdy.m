%%% 基本形态滤波单元构建
function out=xtdy(f,g)%%  f：输入函数；g：结构函数 
%%%先开-闭运算
fg=funopen(f,g);
fkb=funclose(fg,g);
%%%再闭-开运算
fk=funclose(f,g);
fbk=funopen(fk,g);
%%%求均值输出
out=(fkb+fbk)/2;