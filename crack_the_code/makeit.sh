
echo Compiling $1
link_output=${1%.*}.obj
exec_output=${1%.*}.l
clang++ -std=c++11 -o $link_output -c $1
clang++ -o $exec_output $link_output
