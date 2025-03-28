require 'gosu'

class FillSimulacion
  attr_accessor :ram

  PANTALLA = 16384  # Dirección base de la pantalla
  TECLADO = 24575   # Dirección del teclado en RAM

  def initialize
    @ram = Array.new(24576, 0) # Simulación de la RAM
  end

  def ejecutar_ciclo
    if @ram[TECLADO] != 0  # Si hay una tecla presionada
      (0..8191).each { |i| @ram[PANTALLA + i] = -1 }  # Pantalla negra
    else
      (0..8191).each { |i| @ram[PANTALLA + i] = 0 }  # Pantalla blanca
    end
  end
end

class Ventana < Gosu::Window
  def initialize(simulacion)
    super 1200, 800
    self.caption = "Simulación de Fill.hack"
    @simulacion = simulacion
  end

  def update
    @simulacion.ejecutar_ciclo  # Ejecutar la lógica del 
  end

  def draw
    color = @simulacion.ram[FillSimulacion::PANTALLA] == -1 ? Gosu::Color::BLACK : Gosu::Color::WHITE
    draw_quad(0, 0, color, 1200, 0, color, 1200, 800, color, 0, 800, color)
  end

  def button_down(id)
    @simulacion.ram[FillSimulacion::TECLADO] = 1  # Simula una tecla presionada en la RAM
  end

  def button_up(id)
    @simulacion.ram[FillSimulacion::TECLADO] = 0  # Simula que se soltó la tecla en la RAM
  end
end

# Crear la simulación y lanzar la ventana
simulacion = FillSimulacion.new
Ventana.new(simulacion).show
