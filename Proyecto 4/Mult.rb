require 'gosu'

class MultSimulacion
  attr_accessor :ram, :historial

  def initialize
    @ram = Array.new(3, 0)  # RAM con 3 posiciones (RAM[0], RAM[1], RAM[2])
    @historial = []  # Guardará los cambios de RAM
    @contador = 0  # Número de iteraciones realizadas
  end

  def ejecutar_ciclo
    return if @contador >= 6  # Si ya se hicieron 6 iteraciones, no hacer más

    # Generar valores aleatorios en cada ciclo
    @ram[0] = rand(0..10)
    @ram[1] = rand(0..10)
    @ram[2] = @ram[0] * @ram[1]

    # Guardar la fila en la tabla
    @historial << [@ram[0], @ram[1], @ram[2]]

    @contador += 1  # Aumentar el contador
  end
end

class Ventana < Gosu::Window
  def initialize(simulacion)
    super 800, 600
    self.caption = "Simulación de Mult.asm"
    @simulacion = simulacion
    @fuente = Gosu::Font.new(20)
    @terminado = false  # Indica si ya se completaron las 6 iteraciones
  end

  def update
    unless @terminado
      @simulacion.ejecutar_ciclo  # Ejecutar ciclo de multiplicación
      sleep(0.5)  # Esperar un poco para visualizar el cambio

      # Si ya se hicieron 6 iteraciones, marcar como terminado
      @terminado = true if @simulacion.historial.length >= 6
    end
  end

  def draw
    draw_rect(0, 0, 800, 600, Gosu::Color::WHITE)

    # Dibujar encabezados
    @fuente.draw_text("| RAM[0]  | RAM[1]  | RAM[2]  |", 100, 50, 0, 1.0, 1.0, Gosu::Color::BLACK)

    # Dibujar los valores de la tabla
    @simulacion.historial.each_with_index do |fila, i|
      @fuente.draw_text("| #{fila[0].to_s.ljust(6)}      |    #{fila[1].to_s.ljust(6)}    |   #{fila[2].to_s.ljust(6)}   |", 
                        100, 80 + (i * 30), 0, 1.0, 1.0, Gosu::Color::BLACK)
    end

    # Mensaje cuando la simulación termine
    @fuente.draw_text("Odiamos Ruby AYUDA!!!", 200, 550, 0, 1.0, 1.0, Gosu::Color::RED) if @terminado
  end
end

# Crear la simulación y lanzar la ventana
simulacion = MultSimulacion.new
Ventana.new(simulacion).show
