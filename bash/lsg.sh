#!/bin/bash
#Выводим текущие разрешения
ls -apl /dev | grep vmnet
#Сохраняем значения в переменную
lsg=`ls /dev/ | grep vmnet`
#В цикле пробегаем по каждому vmnet
for count in $lsg
do
	#И меняем разрешение
	chmod a+wr /dev/$count
done
echo "Permissions changed..."
echo "Result:"
#Выводим результат
ls -apl /dev | grep vmnet
