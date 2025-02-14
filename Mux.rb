# Definimos la compuerta MUX
def puerta_mux(a, b, sel)
  sel == 0 ? a : b
end

# Imprimir tabla de verdad
puts "Tabla de verdad para la compuerta MUX:"
puts "Entrada A | Entrada B | Selección | Salida"
puts "---------------------------------------"
[0, 1].each do |a|
  [0, 1].each do |b|
    [0, 1].each do |sel|
      resultado = puerta_mux(a, b, sel)
      puts "#{a}        | #{b}        | #{sel}        | #{resultado}"
    end
  end
end

# Pruebas
casos_de_prueba = [[0, 0, 0, 0], [0, 1, 0, 0], [1, 0, 1, 0], [1, 1, 1, 1]]

casos_de_prueba.each do |a, b, sel, esperado|
  resultado = puerta_mux(a, b, sel)
  raise "Error: MUX(#{a}, #{b}, #{sel}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de MUX pasaron exitosamente"
