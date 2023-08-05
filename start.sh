#!/bin/bash

# Java可执行文件路径
JAVA_EXECUTABLE="/path/to/java"

# JAR文件路径
JAR_FILE="./spider-flow.jar"

# log文件路径
LOG_JAR_FILE="./data/spider/logs/logs.log"

# Java虚拟机参数
JAVA_OPTS="-Xmx512m -Xms256m"

# 启动命令
#$JAVA_EXECUTABLE $JAVA_OPTS -jar $JAR_FILE > /dev/null 2>&1 &


nohup java -jar $JAR_FILE > $LOG_JAR_FILE 2>&1 &

tail -f ./data/spider/logs/logs.log