# Zookeeper Monitoring Template

This Zabbix template for monitoring Apache Zookeeper instances using the `zookeeper-metric` command. The template is designed to collect various metrics from Zookeeper, such as connection statistics, latency, and server state, and trigger alerts based on predefined thresholds.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Triggers](#triggers)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Zookeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. Monitoring Zookeeper is crucial to ensure its health and performance. This Zabbix template allows you to monitor Zookeeper instances by collecting metrics through the `zookeeper-metric` command.

## Features

- **Comprehensive Metrics Collection**: The template collects a wide range of metrics, including:
  - Connection statistics (received, sent, queued)
  - Data size and znode count
  - Latency (average, minimum, maximum)
  - File descriptor usage
  - Server state (leader, follower, standalone)
  - Watch count and outstanding requests

- **Predefined Triggers**: The template includes triggers for common issues such as:
  - High file descriptor usage
  - Excessive queued requests
  - Server mode changes
  - Server running in an error state

- **Customizable Macros**: The template allows you to customize alert thresholds using Zabbix macros.

## Prerequisites

- Zabbix Server (version 7.0 or higher)
- Apache Zookeeper instance (version 3.5.3 or higher recommended)
- Access to the Zookeeper server to execute the `zookeeper-metric` command

## Installation

1. **Download the Template**:
   - Download the `template_zookeeper_script.yaml` file from this repository.
   - Download the `zookeeper-metric` command file from this repository.Then upload to server.

2. **Import the Template into Zabbix**:
   - Log in to your Zabbix server.
   - Navigate to **Configuration** > **Templates**.
   - Click on **Import** and upload the `template_zookeeper_script.yaml` file.

3. **Add UserParameter in Zabbix Agent config file**:
   - Add UserParameter in Zabbix Agent config file.then restart Zabbix Agent. For example:
     ```
     # vi /etc/zabbix/zabbix_agentd.conf
     UnsafeUserParameters=1
     UserParameter=zookeeper.metric[*],{PATH_TO_SCRIPT}/zookeeper-metric $1 $2
     
     # systemctl restart zabbix-agent
     
     ```

4. **Link the Template to a Host**:
   - Navigate to **Configuration** > **Hosts**.
   - Select the host running Zookeeper.
   - In the **Templates** tab, link the `Zookeeper by Script` template to the host.

## Configuration

### Macros

The template uses the following macros to define thresholds and connection details:

- `{$ZOOKEEPER.FILE_DESCRIPTORS.MAX.WARN}`: Maximum percentage of file descriptors usage before triggering an alert (default: `85`).
- `{$ZOOKEEPER.OUTSTANDING_REQ.MAX.WARN}`: Maximum number of outstanding requests before triggering an alert (default: `20`).
- `{$ZOOKEEPER_HOST}`: The hostname or IP address and port of the Zookeeper server (default: `127.0.0.1:2181`).

You can modify these macros in the Zabbix frontend under **Configuration** > **Templates** > **Macros**.

### Value Maps

The template includes two value maps:

- **read-only**: Maps Zookeeper's read-only mode status to human-readable values.
- **ruok**: Maps Zookeeper's `ruok` command response to indicate whether the server is running in a non-error state.

## Usage

Once the template is imported and linked to a host, Zabbix will automatically start collecting metrics from the Zookeeper server. You can view the collected data and trigger statuses in the Zabbix frontend under **Monitoring** > **Latest data**.

### Key Metrics

- **Zookeeper connection recved**: Number of connections received by the Zookeeper server.
- **Zookeeper connection sent**: Number of connections sent by the Zookeeper server.
- **Zookeeper approximate data size**: Approximate size of the data tree in bytes.
- **Zookeeper latency avg**: Average latency for client requests.
- **Zookeeper server mode**: Current mode of the Zookeeper server (leader, follower, or standalone).

## Triggers

The template includes several predefined triggers to alert you of potential issues:

- **Zookeeper: Too many file descriptors used**: Triggered when the number of file descriptors used exceeds the defined threshold.
- **Zookeeper: Too many queued requests**: Triggered when the number of outstanding requests exceeds the defined threshold.
- **Zookeeper: Server mode has changed**: Triggered when the Zookeeper server's mode changes.
- **Zookeeper: running in an error state**: Triggered when the Zookeeper server is not running in a non-error state.

## Repository
The source code of this template and related scripts can be found at [https://github.com/min-organization/zabbix](https://github.com/min-organization/zabbix).