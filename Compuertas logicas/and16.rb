def puerta_and16(a, b)
  a.zip(b).map { |x, y| x & y }
end

# Pruebas
casos_de_prueba = [
  [[0]*16, [0]*16, [0]*16],
  [[1]*16, [1]*16, [1]*16],
  [[1, 0]*8, [0, 1]*8, [0]*16]
]

casos_de_prueba.each do |a, b, esperado|
  resultado = puerta_and16(a, b)
  raise "Error: AND16(#{a}, #{b}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de AND16 pasaron exitosamente "
