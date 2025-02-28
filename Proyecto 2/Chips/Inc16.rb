class Inc16
  def self.increment(input)
    raise ArgumentError, "Confirmamos que sea un arreglo de 16bits" unless input.is_a?(Array) && input.size == 16
    
    result = (input.join.to_i(2) + 1) & 0xFFFF
    
    result.to_s(2).rjust(16, '0').chars.map(&:to_i)
  end
end

# Casos de prueba
test_cases = [
  [0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1],
  [1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,0],
  [1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1]
]

# Encabezado
puts "+------------------+------------------+"
puts "|      Input       |      Output      |"
puts "+------------------+------------------+"

test_cases.each do |input|
  output = Inc16.increment(input)
  puts "| #{input.join} | #{output.join} |"
end

puts "+------------------+------------------+"

