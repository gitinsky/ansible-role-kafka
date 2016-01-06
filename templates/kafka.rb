Eye.application 'kafka' do
  working_dir '/opt/kafka'
  stdall '/var/log/eye/kafka-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes
  uid "kafka"

  process :kafka do
    pid_file '/var/lib/kafka-logs/kafka_server.pid'
    start_command '/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
