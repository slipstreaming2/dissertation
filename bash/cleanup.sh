save_location="${1}/${3}"

echo rm -rf ${save_location}/minion
echo rm -rf ${save_location}/symmetry
if [[ "$2" == "y" ]]; then 
    echo rm -rf ${save_location}/fzn 
fi