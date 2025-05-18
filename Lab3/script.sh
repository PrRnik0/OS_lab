#!/bin/bash

if [ -z "$1" ]; then
    echo "Использование: $0 <исходная_папка> [целевая_папка]"
    exit 1
fi

source_dir="$1"

if [ -z "$2" ]; then
    backup_dir="$(pwd)/backup_$(date +'%Y%m%d_%H%M%S')"
else
    backup_dir="$2/backup_$(date +'%Y%m%d_%H%M%S')"
fi

mkdir -p "$backup_dir" || { echo "Ошибка создания папки бэкапа"; exit 1; }

echo "Начинаю резервное копирование изображений из $source_dir в $backup_dir"

count=0
while IFS= read -r -d '' file; do
    rel_path="${file#$source_dir/}"
    mkdir -p "$backup_dir/$(dirname "$rel_path")"
    cp -v "$file" "$backup_dir/$rel_path"
    ((count++))
done < <(find "$source_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" \) -print0)

echo "Готово! Скопировано $count файлов."