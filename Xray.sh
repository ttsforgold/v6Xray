#!/bin/bash

# 定义颜色代码
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

# 函数用于安装 Xray
install_vless_reality() {
   # 调用你自己的安装脚本
   bash <(curl -fsSL https://raw.githubusercontent.com/ttsforgold/v6Xray/main/xray.sh)
}

# 函数用于卸载 Xray
uninstall_vless_reality() {
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ remove --purge
}

# 检查安装状态
check_vless_reality_status() {
    command -v xray &> /dev/null
}

# 检查运行状态
check_vless_reality_running() {
    systemctl is-active --quiet xray
}

# 显示菜单
show_menu() {
    clear
    echo -e "${GREEN}=== Xray 管理工具 ===${RESET}"
    echo -e "安装状态: $(if check_vless_reality_status; then echo -e "${GREEN}已安装${RESET}"; else echo -e "${RED}未安装${RESET}"; fi)"
    echo -e "运行状态: $(if check_vless_reality_running; then echo -e "${GREEN}已运行${RESET}"; else echo -e "${RED}未运行${RESET}"; fi)"
    echo ""
    echo "1. 安装 Xray 服务"
    echo "2. 卸载 Xray 服务"
    echo "3. 启动 Xray 服务"
    echo "4. 停止 Xray 服务"
    echo "5. 重启 Xray 服务"
    echo "6. 检查 Xray 状态"
    echo "7. 查看 Xray 日志"
    echo "8. 查看 Xray 配置"
    echo "0. 退出"
    echo -e "=====================${RESET}"
    read -p "请输入选项编号: " choice
    echo ""
}

trap 'echo -e "${RED}已取消操作${RESET}"; exit' INT

while true; do
    show_menu
    case "$choice" in
        1) install_vless_reality ;;
        2) uninstall_vless_reality ;;
        3) systemctl start xray ;;
        4) systemctl stop xray ;;
        5) systemctl restart xray ;;
        6) systemctl status xray ;;
        7) journalctl -u xray -f ;;
        8) cat /usr/local/etc/xray/config.txt ;;
        0) echo -e "${GREEN}已退出 Xray 管理工具${RESET}"; exit 0 ;;
        *) echo -e "${RED}无效的选项${RESET}" ;;
    esac
    read -p "按 Enter 键继续..."
done
