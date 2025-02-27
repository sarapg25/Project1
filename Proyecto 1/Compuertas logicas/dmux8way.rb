def puerta_dmux8way(entrada, sel)
  salida = [0, 0, 0, 0, 0, 0, 0, 0]
  salida[sel] = entrada
  salida
end

# Pruebas
casos_de_prueba = [
  [1, 0, [1, 0, 0, 0, 0, 0, 0, 0]],
  [1, 1, [0, 1, 0, 0, 0, 0, 0, 0]],
  [1, 4, [0, 0, 0, 0, 1, 0, 0, 0]],
  [1, 7, [0, 0, 0, 0, 0, 0, 0, 1]]
]

casos_de_prueba.each do |entrada, sel, esperado|
  resultado = puerta_dmux8way(entrada, sel)
  raise "Error: DMUX8Way(#{entrada}, #{sel}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de DMUX8Way pasaron exitosamente "
