# frozen_string_literal: true

print 'Text?:'
text = gets.chomp

begin
  print 'Pattern?:'
  pattern = gets.chomp
  regexp = Regexp.new(pattern)
rescue RegexpError => e
  puts "invalid pattern:#{e.message}"
  retry
end
matches = text.scan(regexp)
if !matches.empty?
  puts "Matched:#{matches.join(',')}"
else
  puts 'Nothing matched.'
end
