for f in /home/cb373/usr/temp/dissertation/instances_and_solutions/*; do
    cd $f/minizinc/free_chuffed
    find . -name "*dzn_run*" -print0 | xargs -0 rm -rf
    find . -name "*json_run*" -print0 | xargs -0 rm -rf
done