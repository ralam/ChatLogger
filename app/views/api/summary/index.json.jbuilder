# helper method to generate frequency hash, zeros must be set to ensure they're printed in JSON object

def generate_freq_hash
  counts = Hash.new
  counts[:date]
  counts[:enters] = 0
  counts[:leaves] = 0
  counts[:comments] = 0
  counts[:highfives] = 0

  counts
end

#helper method used to increment frequency hash

def count_freq(event, freq_hash)
  action = event.type_of
  if action == "enter"
    freq_hash[:enters] += 1
  elsif action == "leave"
    freq_hash[:leaves] += 1
  elsif action == "comment"
    freq_hash[:comments] += 1
  elsif action == "highfive"
    freq_hash[:highfives] += 1
  end

  freq_hash
end

#helper method used to add last interval data

def add_last_interval(current_time, freq_hash, intervals)
  freq_hash[:date] = current_time
  intervals << freq_hash
end

#main view

counts = generate_freq_hash
if @interval
  intervals = []
  @events.order!(date: :asc)
  if @interval == 'minute'

    current_time = @events[0].date
    current_time.change({seconds: 0})
    @events.each do |event|
      while current_time < event.date
        counts[:date] = current_time
        intervals << counts
        counts = generate_freq_hash
        current_time += 1.minutes
      end

      counts = count_freq(event, counts)
    end
    intervals = add_last_interval(current_time, counts, intervals)
    if @to_date
      while current_time < @to_date
        counts = generate_freq_hash
        current_time += 1.minutes
        counts[:date] = current_time
        intervals << counts
      end
    end
  elsif @interval == 'hour'
    current_time = @events[0].date
    current_time.change({minutes: 0})
    @events.each do |event|
      while current_time + 1.hours <= event.date
        counts[:date] = current_time
        intervals << counts
        counts = generate_freq_hash
        current_time += 1.hours
      end

      counts = count_freq(event, counts)
      if @to_date
        while current_time < @to_date
          counts = generate_freq_hash
          current_time += 1.hours
          counts[:date] = current_time
          intervals << counts
        end
      end
    end
    intervals = add_last_interval(current_time, counts, intervals)
  elsif @interval == 'day'
    current_time = @events[0].date
    current_time = current_time.beginning_of_day
    @events.each do |event|
      while current_time + 1.days <= event.date
        counts[:date] = current_time
        intervals << counts
        counts = generate_freq_hash
        current_time += 1.days
      end

      counts = count_freq(event, counts)
    end

    intervals = add_last_interval(current_time, counts, intervals)
    if @to_date
      while current_time < @to_date
        counts = generate_freq_hash
        current_time += 1.days
        counts[:date] = current_time
        intervals << counts
      end
    end
  end
  json.array! intervals
else
  @events.each do |event|
    counts = count_freq(event, counts)
  end

  json.enters counts[:enters]
  json.leaves counts[:leaves]
  json.comments counts[:comments]
  json.highfives counts[:highfives]
end
