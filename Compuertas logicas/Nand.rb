# Definimos la compuerta NAND
def nand(a, b)
  return 1 unless a == 1 && b == 1 # Solo devuelve 0 si ambas entradas son 1
  return 0
end

# Pruebas
puts "NAND(0,0) = #{nand(0, 0)}" # Debe imprimir 1
puts "NAND(0,1) = #{nand(0, 1)}" # Debe imprimir 1
puts "NAND(1,0) = #{nand(1, 0)}" # Debe imprimir 1
puts "NAND(1,1) = #{nand(1, 1)}" # Debe imprimir 0
