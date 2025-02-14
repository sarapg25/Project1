# Definimos la compuerta XOR
def puerta_xor(a, b)
  a ^ b
end

# Imprimir tabla de verdad
puts "Tabla de verdad para la compuerta XOR:"
puts "Entrada A | Entrada B | Salida"
puts "---------------------------"
[0, 1].each do |a|
  [0, 1].each do |b|
    resultado = puerta_xor(a, b)
    puts "#{a}        | #{b}        | #{resultado}"
  end
end

# Pruebas
casos_de_prueba = [[0, 0, 0], [0, 1, 1], [1, 0, 1], [1, 1, 0]]

casos_de_prueba.each do |a, b, esperado|
  resultado = puerta_xor(a, b)
  raise "Error: XOR(#{a}, #{b}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de XOR pasaron exitosamente"
