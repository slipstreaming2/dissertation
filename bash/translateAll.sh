for f in ${1}/*.dzn; do
    python ../python/translator.py "$f" "$2"
done