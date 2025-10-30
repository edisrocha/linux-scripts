#!/bin/bash
# 💾 Backup Automation Script
# Autor: Edi Rocha
# Descrição: Cria backup de arquivos importantes

BACKUP_DIR="/home/$USER/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_$DATE.tar.gz"

# Diretórios para backup
DIRECTORIES=(
    "/home/$USER/documentos"
    "/home/$USER/projetos"
    "/home/$USER/scripts"
)

echo "Iniciando backup..."

# Criar diretório de backup se não existir
mkdir -p $BACKUP_DIR

# Criar backup
tar -czf $BACKUP_DIR/$BACKUP_NAME ${DIRECTORIES[@]} 2>/dev/null

# Verificar se backup foi criado
if [ -f "$BACKUP_DIR/$BACKUP_NAME" ]; then
    echo "Backup criado: $BACKUP_NAME"
    echo "Tamanho: $(du -h $BACKUP_DIR/$BACKUP_NAME | cut -f1)"
    
    # Limpar backups antigos (mais de 30 dias)
    find $BACKUP_DIR -name "backup_*.tar.gz" -mtime +30 -delete
    echo "Backups antigos removidos"
else
    echo "Erro ao criar backup"
    exit 1
fi
