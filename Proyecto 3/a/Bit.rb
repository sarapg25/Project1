# Implementación del Multiplexor (Mux)
def mux(a, b, sel)
  sel == 1 ? b : a
end

# Implementación del Flip-Flop tipo D (DFF) con clock explícito
class DFF
  def initialize
    @state = 0  # Estado inicial
    @prev_clock = 0  # Estado anterior del clock
  end

  def tick(input, clock)
    # Solo actualiza el estado en el flanco ascendente del clock
    if clock == 1 && @prev_clock == 0
      @state = input
    end
    @prev_clock = clock  # Guarda el estado actual del clock
  end

  def output
    @state
  end
end

# Implementación del Bit usando Mux y DFF con clock explícito
class Bit
  def initialize
    @dff = DFF.new
  end

  def tick(input, load, clock)
    # Multiplexor decide si tomamos la entrada o mantenemos el estado
    mux_output = mux(@dff.output, input, load)
    
    # Se guarda el valor en el Flip-Flop solo en el flanco del clock
    @dff.tick(mux_output, clock)
  end

  def output
    @dff.output
  end
end

# Prueba del registro de 1 bit con clock explícito
bit = Bit.new

# Casos de prueba para simular el comportamiento
# Cada caso es [input, load, clock]
test_cases = [
  [0, 1, 1],  # in = 0, load = 1, clock = 1 (flanco ascendente)
  [0, 1, 0],  # in = 0, load = 1, clock = 0 (no cambia)
  [1, 1, 1],  # in = 1, load = 1, clock = 1 (flanco ascendente)
  [1, 1, 0],  # in = 1, load = 1, clock = 0 (no cambia)
  [0, 0, 1],  # in = 0, load = 0, clock = 1 (mantiene el estado)
  [0, 0, 0],  # in = 0, load = 0, clock = 0 (no cambia)
  [1, 0, 1],  # in = 1, load = 0, clock = 1 (mantiene el estado)
  [1, 0, 0],  # in = 1, load = 0, clock = 0 (no cambia)
]

puts "in | load | clock | out"
puts "-----------------------"

test_cases.each do |input, load, clock|
  bit.tick(input, load, clock)
  puts "#{input}  |  #{load}   |  #{clock}    |  #{bit.output}"
end