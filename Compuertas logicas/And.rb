# Definimos la compuerta AND
def puerta_and(a, b)
  a & b
end

# Imprimir tabla de verdad
puts "Tabla de verdad para la compuerta AND:"
puts "Entrada A | Entrada B | Salida"
puts "---------------------------"
[0, 1].each do |a|
  [0, 1].each do |b|
    resultado = puerta_and(a, b)
    puts "#{a}        | #{b}        | #{resultado}"
  end
end

# Pruebas
casos_de_prueba = [[0, 0, 0], [0, 1, 0], [1, 0, 0], [1, 1, 1]]

casos_de_prueba.each do |a, b, esperado|
  resultado = puerta_and(a, b)
  raise "Error: AND(#{a}, #{b}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de AND pasaron exitosamente"
