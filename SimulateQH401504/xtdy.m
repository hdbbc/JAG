%%% ������̬�˲���Ԫ����
function out=xtdy(f,g)%%  f�����뺯����g���ṹ���� 
%%%�ȿ�-������
fg=funopen(f,g);
fkb=funclose(fg,g);
%%%�ٱ�-������
fk=funclose(f,g);
fbk=funopen(fk,g);
%%%���ֵ���
out=(fkb+fbk)/2;