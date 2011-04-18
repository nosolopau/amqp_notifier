class AmqpNotifier
  DEFAULT_EXCHANGE = 'labs_tests_1'
  DEFAULT_OPTIONS = {:durable => true, :nowait => false, :type => :topic}
  DEFAULT_PREFIX = ''
  DEFAULT_QUEUE = 'default'
  
  def initialize(exchange = DEFAULT_EXCHANGE, queue = DEFAULT_QUEUE, key_prefix = DEFAULT_PREFIX, options = DEFAULT_OPTIONS)
    @key_prefix = key_prefix
    @exchange = exchange
    @options = options
    @queue = queue
  end
  
  def publish(key = '', message = '')
    Qusion.channel.topic(@exchange, @options).publish(message, :key => @key_prefix + key)
  end
  
  def subscribe(key = '', &block)
    Qusion.channel.prefetch(1).queue(@queue, :durable => true).bind(Qusion.channel.topic(@exchange, @options), :key => key).subscribe(:ack => true) do |info, message|
      yield info, message
      info.ack
    end
  end
end