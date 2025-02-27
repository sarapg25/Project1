def puerta_not16(entrada)
  entrada.map { |bit| bit == 1 ? 0 : 1 }
end

# Pruebas
casos_de_prueba = [
  [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
  [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
]

casos_de_prueba.each do |entrada, esperado|
  resultado = puerta_not16(entrada)
  raise "Error: NOT16(#{entrada}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de NOT16 pasaron exitosamente "
