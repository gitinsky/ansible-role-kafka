Eye.application 'zookeeper-kafka' do
  working_dir '/opt/kafka'
  stdall '/var/log/eye/zookeeper-kafka-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes
  uid "kafka"

  process :zookeeper_kafka do
    pid_file '/var/lib/zookeeper-kafka/zookeeper_server.pid'
    start_command '/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
