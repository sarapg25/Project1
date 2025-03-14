
class Bit
  def initialize
    @state = 0 # Estado inicial en 0
  end

  # Guarda input solo si load = 1
  def tick(input, load)
    @state = input & 0x1 if load == 1
    @state # Devuelve el valor almacenado
  end
end

# 🔹 Registro de 16 Bits (Usa 16 flip-flops individuales)
class Register
  def initialize
    @bits = Array.new(16) { Bit.new } # 16 Flip-Flops (Bits)
  end

  # Si load = 1, guarda el input en cada bit del registro
  def tick(input, load)
    output = 0
    @bits.each_with_index do |bit, i|
      bit_value = bit.tick((input >> i) & 0x1, load) # Extraer y guardar cada bit
      output |= (bit_value << i) # Reconstruir el número de 16 bits
    end
    output # Devuelve el contenido actual del registro
  end
end

# 🔹 Casos de prueba actualizados
test_cases = [
  # Casos básicos
  [0x1234, 1, 0x1234], # Escribir 0x1234 en el registro
  [0x5678, 0, 0x1234], # No cargar (debe mantener 0x1234)
  [0x9ABC, 1, 0x9ABC], # Escribir 0x9ABC en el registro
  [0xDEF0, 0, 0x9ABC], # No cargar (debe mantener 0x9ABC)

  # Casos límite
  [0x0000, 1, 0x0000], # Escribir 0 (vaciar el registro)
  [0xFFFF, 1, 0xFFFF], # Escribir 16 bits en 1 (máximo valor)
  [0x0000, 0, 0xFFFF], # No cargar (debe mantener 0xFFFF)
  [0x8000, 1, 0x8000], # Escribir solo el bit más alto
  [0x0001, 1, 0x0001], # Escribir solo el bit más bajo

  # Escrituras sucesivas
  [0xAAAA, 1, 0xAAAA], # Alternado 1010101010101010
  [0x5555, 1, 0x5555], # Alternado 0101010101010101
  [0x0F0F, 1, 0x0F0F], # Alternado en grupos de 4 bits
  [0xF0F0, 1, 0xF0F0], # Complemento del anterior

  # Combinaciones con load = 0
  [0x1234, 1, 0x1234], # Escribir 0x1234
  [0x5678, 0, 0x1234], # No cargar, debe seguir 0x1234
  [0x9ABC, 0, 0x1234], # No cargar, debe seguir 0x1234
  [0xDEF0, 1, 0xDEF0], # Ahora sí escribir 0xDEF0
]

# 🔹 Ejecutar Pruebas
def run_tests(register, test_cases)
  puts " input  | load | out (hex)"
  puts "--------------------------"

  test_cases.each do |input, load, expected_out|
    out = register.tick(input, load)
    puts " 0x#{input.to_s(16).rjust(4, '0')} |  #{load}   |  0x#{out.to_s(16).rjust(4, '0')}"
  end
end

# Crear un registro y ejecutar pruebas
register = Register.new
run_tests(register, test_cases)
