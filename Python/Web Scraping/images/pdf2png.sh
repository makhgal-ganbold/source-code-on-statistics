#!/bin/bash
# Хавтас доторх бүх PDF файлыг PNG болгож хөрвүүлэх

for f in *.pdf; do
	filename=$(basename "$f" .pdf)
	convert -density 200 "$f" -background white -flatten "${filename}.png"
done
