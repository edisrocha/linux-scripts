#!/bin/bash
# 📊 System Monitoring Script
# Autor: Edi Rocha
# Descrição: Mostra estatísticas do sistema em tempo real

echo "RELATÓRIO DO SISTEMA - $(date)"
echo "=========================================="

# Informações do sistema
echo "HOSTNAME: $(hostname)"
echo "KERNEL: $(uname -r)"
echo "UPTIME: $(uptime -p)"

# Uso de CPU
echo "CPU:"
echo "  Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "  Cores: $(nproc)"

# Memória
echo "MEMÓRIA:"
free -h | awk '
NR==1{print "  " $0}
NR==2{print "  Total: " $2 " | Usada: " $3 " | Livre: " $4}
NR==3{print "  Swap - Total: " $2 " | Usada: " $3}'

# Disco
echo "DISCO:"
df -h / | awk 'NR==2{print "  Total: " $2 " | Usado: " $3 " (" $5 ") | Livre: " $4}'

# Rede
echo "REDE:"
echo "  IP: $(hostname -I | awk '{print $1}')"
echo "  Conexões: $(netstat -tun | grep ESTABLISHED | wc -l)"

# Serviços Docker (se existirem)
if command -v docker &> /dev/null; then
    echo "🐳 DOCKER:"
    echo "  Containers: $(docker ps -q | wc -l) ativos"
    echo "  Imagens: $(docker images -q | wc -l)"
fi

echo "=========================================="
