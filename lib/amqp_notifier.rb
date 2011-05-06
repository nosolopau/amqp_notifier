class AmqpNotifier
  DEFAULT_EXCHANGE = 'labs_tests_1'
  DEFAULT_OPTIONS = {:durable => true, :type => :topic}
  DEFAULT_PREFIX = ''
  DEFAULT_QUEUE = 'default'
  RETRIES = 10
  
  def initialize(exchange = DEFAULT_EXCHANGE, queue = DEFAULT_QUEUE, key_prefix = DEFAULT_PREFIX, options = DEFAULT_OPTIONS)
    @key_prefix = key_prefix
    @exchange = exchange
    @options = options
    @queue = queue
  end
  
  def publish(key = '', message = '')
    $stderr.puts "#{key}:"
    $stderr.puts "#{message}"
    Qusion.channel.topic(@exchange, @options).publish(message, :key => @key_prefix + key)
  end
  
  def subscribe(key = '', &block)
    $stdout.puts "Subscriction to Exchange: #{@exchange} Queue: #{@queue} Key: #{key}"
    Qusion.channel.prefetch(1).queue(@queue, :durable => true).bind(Qusion.channel.topic(@exchange, @options), :key => key).subscribe(:ack => true) do |info, message|
      for i in (0..RETRIES)
        begin
          yield info, message
          info.ack
          break
        rescue => e
          $stderr.puts "Error executing block amqp"
          $stderr.puts "#{e.inspect}:"
          e.backtrace.each {|line| $stderr.puts line}
          if i == RETRIES
            AmqpNotifier.new("#{@exchange}_errors").publish(key, message)
            info.reject(:requeue => false)
          else
            sleep(1)          
            next
          end
        end
      end      
    end
  end
end