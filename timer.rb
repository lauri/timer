require "io/console"

class Timer
  def initialize
    @events = [Time.now]
  end

  def toggle!
    @events << Time.now
  end

  def paused?
    @events.size.even?
  end

  def elapsed
    @events
      .each_slice(2)
      .map { |a, b| (b || Time.now) - a }
      .reduce(:+)
  end

  def status
    [
      Time.now.strftime("%T"),
      paused? ? "Paused" : "Timing",
      Time.at(elapsed).utc.strftime("%T")
    ].join(" - ")
  end
end

timer = Timer.new

loop do
  puts timer.status
  case STDIN.getch
  when "q", "\u0003" then puts timer.status; break
  when "p", "\u0020" then timer.toggle!
  end
end
