#!/bin/bash
# 🔄 System Update & Maintenance Script
# Autor: Edi Rocha
# Descrição: Atualiza sistema e limpa arquivos temporários

echo "Iniciando atualização do sistema..."

# Atualizar lista de pacotes
sudo apt update

# Atualizar pacotes
sudo apt upgrade -y

# Atualizar distribuição (se houver)
sudo apt full-upgrade -y

# Remover pacotes não utilizados
sudo apt autoremove -y
sudo apt autoclean

# Limpar cache
sudo apt clean

# Limpar logs antigos
sudo journalctl --vacuum-time=7d

# Limpar arquivos temporários
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

echo "Sistema atualizado e limpo!"
echo "Espaço liberado:"
df -h /
