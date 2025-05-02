=begin
1. La clase Code convierte cada texto extraído de la clase Parse en su valor binario correspondiente (16 bits).
2. Se hace referencia a la tabla de verdad proporcionada por la clase Nand2Tetris en Coursera.
3. El código ensamblador está escrito en el lenguaje Hack.

Ejemplo:
Instrucción A:
@21 ->   0000000000010101

Instrucción C:
D=D+1 -> 1110011111010000
=end
require "./parser.rb"

class Code
  include Parser

  # Tabla de saltos para instrucciones de salto (JMP, JGE, etc.)
  @@jump_table = {
    "JGT" => "001", "JEQ" => "010", "JGE" => "011",
    "JLT" => "100", "JNE" => "101", "JLE" => "110", "JMP" => "111"
  }

  # Tabla de computaciones (C-instructions) con sus valores binarios correspondientes
  @@comp_table = {
    "0"   => "101010",
    "1"   => "111111",
    "-1"  => "111010",
    "D"   => "001100",
    "A"   => "110000",
    "!D"  => "001101",
    "!A"  => "110001",
    "-D"  => "001111",
    "-A"  => "110011",
    "D+1" => "011111",
    "A+1" => "110111",
    "D-1" => "001110",
    "A-1" => "110010",
    "D+A" => "000010",
    "D-A" => "010011",
    "A-D" => "000111",
    "D&A" => "000000",
    "D|A" => "010101",
    "M"   => "110000",
    "!M"  => "110001",
    "-M"  => "110011",
    "M+1" => "110111",
    "M-1" => "110010",
    "D+M" => "000010",
    "D-M" => "010011",
    "M-D" => "000111",
    "D&M" => "000000",
    "D|M" => "010101"
  }

  # Inicializa la clase con una instrucción (str) y una tabla de símbolos opcional
  def initialize(str, symbol_table = nil)
    @str = str
    @symbol_table = symbol_table
  end

  # Método principal para compilar la instrucción
  def compile
    case type  # Determina el tipo de instrucción
    when A_INSTRUCTION
      convert_to_binary(_destination)  # Convierte a binario una instrucción A
    when C_INSTRUCTION
      "111" << comp << dest << jump  # Construye la instrucción C (111 + computación + destino + salto)
    when VARIABLE_INSTRUCTION
      convert_to_binary(@symbol_table.read(_destination))  # Convierte la variable a binario usando la tabla de símbolos
    end
  end

  # Métodos de clase que retornan las tablas de computación y salto
  def self.comp_table
    @@comp_table
  end

  def self.jump_table
    @@jump_table
  end

  # Método para determinar el tipo de instrucción (A, C o Variable)
  def type
    if @str.include? "@"
      is_integer?(@str.gsub("@", "")) ? A_INSTRUCTION : VARIABLE_INSTRUCTION
      # Si la instrucción tiene '@', se determina si es una instrucción A o una variable
    elsif @str.start_with?("(") && @str.end_with?(")")
      LABEL_INSTRUCTION  # Instrucción de etiqueta (inicio y fin con paréntesis)
    else
      C_INSTRUCTION  # Si no es A ni etiqueta, es una instrucción C
    end
  end

private

  # Convierte un número decimal a binario con 15 bits
  def convert_to_binary(decimal)
    "0" << ("%015b" % decimal.to_i)  # Formatea el número en binario de 15 bits y le antepone un 0
  end

  # Determina el destino de la instrucción (A, D, M)
  def dest
    if _destination
      %w(A D M).each_with_object("") do |c, str|
        str << (_destination.include?(c) ? "1" : "0")  # Construye la parte binaria de destino
      end
    else
      "000"  # Si no hay destino, retorna "000" (sin destino)
    end
  end

  # Determina el salto de la instrucción (JMP, JLE, etc.)
  def jump
    @@jump_table[_jump] || "000"  # Retorna el valor correspondiente al salto o "000" si no existe
  end

  # Determina la computación en la instrucción C
  def comp
    comp = self._computation  # Obtiene la computación de la instrucción

    # Si la computación no está en la tabla, muestra un error y termina la ejecución
    if @@comp_table[comp].nil?
      puts "[ERROR] Computación inválida: #{comp.inspect} en instrucción #{@str.inspect}"
      exit
    end

    a_bit = comp.include?("M") ? "1" : "0"  # Si la computación involucra 'M', el bit A es 1, de lo contrario es 0
    a_bit + @@comp_table[comp]  # Retorna el valor de la computación con el bit A
  end

  # Verifica si una cadena representa un número entero
  def is_integer?(str)
    str.to_i.to_s == str  # Compara si la cadena convertida a entero es igual a la original
  end
end
