#!/bin/bash

# Назва каталогу для збереження резервних копій
BACKUP_DIR="/home/user/backups"

# Каталоги, які потрібно резервувати
SOURCE_DIRS="/home/user/Documents /home/user/Downloads"

# Час запуску резервного копіювання (у форматі HH:MM)
BACKUP_TIME="02:00"

# Перевірка наявності каталогу для резервних копій
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir "$BACKUP_DIR"
fi

# Створення резервної копії
for dir in $SOURCE_DIRS; do
  # Отримуємо назву каталогу з поточної дати
  backup_dir="$BACKUP_DIR/$(date +%Y-%m-%d-%H-%M)"

  # Створення резервної копії з використанням tar
  find "$SOURCE_DIRS" -name "*.dat" -exec rm {} \;
  tar -czvf "$backup_dir.tar.gz" "$dir"
  echo "Створено резервну копію з $dir в $backup_dir.tar.gz"
done

# Видалення старих резервних копій (наприклад, старше 7 днів)
find "$BACKUP_DIR" -type f -mtime +7 -delete
