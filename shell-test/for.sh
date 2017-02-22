#!/usr/bin

# for in array
for val in 1 2 3 4 5
do
    echo "Value is :$val"
done


arr=(1 2 3 4 5)
for v in ${arr[*]}
do
    echo "value is:$v"
done

# for in files
for FILE in $HOME/.bash*
do
    echo $FILE
done


#until test

a=0

until [ ! $a -lt 10 ]
do
    echo $a
    a=`expr $a + 1`
done
