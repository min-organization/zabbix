// https://github.com/min-organization/zabbix
package main

import (
	"bufio"
	"fmt"
	"net"
	"os"
	"time"
)

func main() {
	if len(os.Args) != 3 {
		fmt.Println("Usage: zookeeper-metric <zookeeper-address> <four-letter-command>")
		fmt.Println("Example: zookeeper-metric 127.0.0.1:2181 ruok")
		os.Exit(1)
	}

	address := os.Args[1]
	command := os.Args[2]

	if len(command) != 4 {
		fmt.Println("Error: Four-letter command must be exactly 4 characters long.")
		os.Exit(1)
	}

	conn, err := net.DialTimeout("tcp", address, 5*time.Second)
	if err != nil {
		fmt.Printf("Error connecting to Zookeeper: %v\n", err)
		os.Exit(1)
	}
	defer conn.Close()

	_, err = conn.Write([]byte(command))
	if err != nil {
		fmt.Printf("Error sending command to Zookeeper: %v\n", err)
		os.Exit(1)
	}

	scanner := bufio.NewScanner(conn)
	for scanner.Scan() {
		fmt.Println(scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		fmt.Printf("Error reading response from Zookeeper: %v\n", err)
		os.Exit(1)
	}
}
