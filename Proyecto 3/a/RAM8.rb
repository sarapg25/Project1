# Simulación del RAM8

# Simulación de un multiplexor de 8 vías de 16 bits
def mux8way16(a, b, c, d, e, f, g, h, sel)
  case sel
  when 0 then a
  when 1 then b
  when 2 then c
  when 3 then d
  when 4 then e
  when 5 then f
  when 6 then g
  when 7 then h
  else
    raise "Invalid selection value: #{sel}"
  end
end

# Simulación de un demultiplexor de 8 vías
def dmux8way(in_val, sel)
  case sel
  when 0 then [in_val, 0, 0, 0, 0, 0, 0, 0]
  when 1 then [0, in_val, 0, 0, 0, 0, 0, 0]
  when 2 then [0, 0, in_val, 0, 0, 0, 0, 0]
  when 3 then [0, 0, 0, in_val, 0, 0, 0, 0]
  when 4 then [0, 0, 0, 0, in_val, 0, 0, 0]
  when 5 then [0, 0, 0, 0, 0, in_val, 0, 0]
  when 6 then [0, 0, 0, 0, 0, 0, in_val, 0]
  when 7 then [0, 0, 0, 0, 0, 0, 0, in_val]
  else
    raise "Invalid selection value: #{sel}"
  end
end

# Simulación de un registro de 16 bits
class Register
  def initialize
    @state = 0 # Estado inicial en 0
  end

  def tick(input, load)
    if load == 1
      @state = input & 0xFFFF # Almacenar el valor de entrada
    end
    @state # Devolver el valor almacenado
  end
end

# Simulación del RAM8
class RAM8
  def initialize
    # Crear 8 registros de 16 bits
    @reg0 = Register.new
    @reg1 = Register.new
    @reg2 = Register.new
    @reg3 = Register.new
    @reg4 = Register.new
    @reg5 = Register.new
    @reg6 = Register.new
    @reg7 = Register.new
  end

  def tick(input, load, address)
    # Demultiplexar la señal de load
    load0, load1, load2, load3, load4, load5, load6, load7 = dmux8way(load, address)

    # Ejecutar cada registro
    out0 = @reg0.tick(input, load0)
    out1 = @reg1.tick(input, load1)
    out2 = @reg2.tick(input, load2)
    out3 = @reg3.tick(input, load3)
    out4 = @reg4.tick(input, load4)
    out5 = @reg5.tick(input, load5)
    out6 = @reg6.tick(input, load6)
    out7 = @reg7.tick(input, load7)

    # Multiplexar la salida
    mux8way16(out0, out1, out2, out3, out4, out5, out6, out7, address)
  end
end

# Prueba del RAM8
ram8 = RAM8.new

# Casos de prueba [input, load, address, expected_out]
test_cases = [
  [0x1234, 1, 0, 0x1234], # Escribir 0x1234 en el registro 0
  [0x5678, 1, 1, 0x5678], # Escribir 0x5678 en el registro 1
  [0x9ABC, 1, 2, 0x9ABC], # Escribir 0x9ABC en el registro 2
  [0xDEF0, 1, 3, 0xDEF0], # Escribir 0xDEF0 en el registro 3
  [0x0000, 0, 0, 0x1234], # Leer del registro 0 (debe ser 0x1234)
  [0x0000, 0, 1, 0x5678], # Leer del registro 1 (debe ser 0x5678)
  [0x0000, 0, 2, 0x9ABC], # Leer del registro 2 (debe ser 0x9ABC)
  [0x0000, 0, 3, 0xDEF0], # Leer del registro 3 (debe ser 0xDEF0)
]

puts " input  | load | address | out (hex)"
puts "----------------------------------"

test_cases.each do |input, load, address, expected_out|
  out = ram8.tick(input, load, address)
  puts " 0x#{input.to_s(16).rjust(4, '0')} |  #{load}   |    #{address}    |  0x#{out.to_s(16).rjust(4, '0')}"
end