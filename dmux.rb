# Definimos la compuerta DMUX
def puerta_dmux(entrada, sel)
  sel == 0 ? [entrada, 0] : [0, entrada]
end

# Imprimir tabla de verdad
puts "Tabla de verdad para la compuerta DMUX:"
puts "Entrada | Selección | Salida 1 | Salida 2"
puts "----------------------------------------"
[0, 1].each do |entrada|
  [0, 1].each do |sel|
    resultado = puerta_dmux(entrada, sel)
    puts "#{entrada}       | #{sel}        | #{resultado[0]}       | #{resultado[1]}"
  end
end

# Pruebas
casos_de_prueba = [[1, 0, [1, 0]], [1, 1, [0, 1]], [0, 0, [0, 0]], [0, 1, [0, 0]]]

casos_de_prueba.each do |entrada, sel, esperado|
  resultado = puerta_dmux(entrada, sel)
  raise "Error: DMUX(#{entrada}, #{sel}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de DMUX pasaron exitosamente"
