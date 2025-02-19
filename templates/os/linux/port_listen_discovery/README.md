# Zabbix Linux TCP Port Listen State Auto-Discovery Template

## Overview
This Zabbix template, is designed to monitor Linux system TCP ports by analyzing a specified file. It has the ability to automatically identify and monitor relevant ports, which is extremely helpful for users to keep track of port status.

## Template Details
- **Discovery Rules**:
  - **Port Discovery**:
    - **Type**: ZABBIX_ACTIVE
    - **Key**: `net.tcp.listen.discovery`
    - **Delay**: 5 minutes
    - **Lifetime**: 1 day
    - It discovers ports and creates item and trigger prototypes accordingly.
- **Item Prototypes**:
  - Monitors the listen state of each discovered port with a key like `net.tcp.listen[{#PORT}]`.
  - Keeps history for 90 days.
- **Trigger Prototypes**:
  - Alerts when a port is not listening with a high priority.

## Usage
1. **Prerequisites**:
   - Ensure Zabbix server is installed and configured correctly.
   - Have a Linux system where you want to monitor TCP ports.
2. **Configuration**:
   - Import the `template_linux_tcp_port_listen_state.yaml` file into your Zabbix server.
   - Create a configuration file `/etc/zabbix/ports.conf` on the monitored Linux system. In this file, list the ports and their corresponding services you want to monitor, one port-service pair per line. For example:
     ```
     22 SSH
     80 http
     443 https
     ```
   - Make sure the `tcp_port_discovery.sh` script is executable and can be run on the monitored Linux system. You may need to adjust the script's permissions using `chmod +x tcp_port_discovery.sh`.
3. **Linking the Template**:
   - Add UserParameter in Zabbix Agent config file.then restart Zabbix Agent. For example:
     ```
     # vi /etc/zabbix/zabbix_agentd.conf
     UnsafeUserParameters=1
     UserParameter=net.tcp.listen.discovery,{PATH_TO_SCRIPT}/tcp_port_discovery.sh
     
     # systemctl restart zabbix-agent
     
     ```
   - Link the imported template to the host in Zabbix that represents the Linux system you want to monitor.

After the above steps are completed, Zabbix will start automatically discovering and monitoring the TCP ports according to the configuration.

## Repository
The source code of this template and related scripts can be found at [https://github.com/min-organization/zabbix](https://github.com/min-organization/zabbix).
